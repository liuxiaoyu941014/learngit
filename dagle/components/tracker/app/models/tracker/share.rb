module Tracker
  class Share

    def self.chart_data(current_user, date)
      date = date.present? ? Date.strptime(date, "%Y-%m") : Date.today
      # 某月的每天记录
      chart_data = []
      (date.beginning_of_month..date.end_of_month).each do |x|
        count = 0
        unless x > Date.today
          sql = "
            select count(s2.*) from sales_distribution_resources s
            join users u on u.id = s.user_id
            join sales_distribution_resources s2 on s.object_type = s2.object_type and s.object_id = s2.object_id
            where u.id = '"+current_user.id.to_s+"' and s2.created_at between '"+ x.beginning_of_day.to_s+"' and '"+x.end_of_day.to_s+"'"
          record = ActiveRecord::Base.connection.exec_query sql
          count  = record.first['count']
        end
        chart_data << {
          label: x.to_s,
          value: count
        }
      end
      return chart_data
    end

    def self.records(current_user, page = 1)
      root_share_records = current_user.sales_distribution_resources.order(created_at: :desc).page(page)
      share_records = []
      root_share_records.each do |record|
        share_records << {
          root:                     record,
          resource:                 record.object,
          visit_count:              get_visit_count(record),
          two_distribution_count:   get_child_record_count(record),
          three_distribution_count: get_last_child_record_count(record)
        }
      end
      return {share_records: share_records, total_pages: root_share_records.total_pages, selected_page: page}
    end

    def self.find_child_two_records(id, current_user, page = 1)
      root_share_record = current_user.sales_distribution_resources.where(id: id).first
      child_records = get_child_record(root_share_record, page)
      share_records = {
        root:     root_share_record,
        resource: root_share_record.object,
        records:  []
      }
      child_records[:records].each do |record|
        share_records[:records] << {
          record: record,
          last_count: get_child_record_count(record)
        }
      end
      return {share_records: share_records, total_pages: child_records[:total_pages], selected_page: page}
    end

    def self.find_child_three_records(two_share_id, current_user, page = 1)
      root_share_record = SalesDistribution::Resource.where(id: two_share_id).first
      return {} unless current_user.sales_distribution_resources.map(&:object).include?(root_share_record.object)
      child_records = get_child_record(root_share_record, page)
      share_records = {
        root: root_share_record,
        resource: root_share_record.object,
        records: child_records[:records]
      }
      return {share_records: share_records, total_pages: child_records[:total_pages], selected_page: page}
    end

    def self.get_child_record(resource, selected_page)
      offset = (selected_page.to_i-1)*20
      sql = "
        select
          g1.*, user1.nickname, user_mobiles.phone_number
        from sales_distribution_resources r1
        join sales_distribution_resource_users u1 on r1.id = u1.resource_id and r1.user_id != u1.user_id
        join sales_distribution_resources g1 on u1.user_id = g1.user_id and r1.object_id = g1.object_id and r1.object_type = g1.object_type
        join users user1 on user1.id = g1.user_id
        join user_mobiles on user_mobiles.user_id = user1.id
        where r1.id = "+resource['id'].to_s+"limit 20 offset "+offset.to_s
      records = ActiveRecord::Base.connection.exec_query sql
      total_pages = records.length / 20
      total_pages += 1 if records.length % 20 > 0
      return {records: records, total_pages: total_pages}
    end

    def self.get_child_record_count(resource)
      sql = "
        select
          count(g1.*)
        from sales_distribution_resources r1
        join sales_distribution_resource_users u1 on r1.id = u1.resource_id and r1.user_id != u1.user_id
        join sales_distribution_resources g1 on u1.user_id = g1.user_id and r1.object_id = g1.object_id and r1.object_type = g1.object_type
        where r1.id = "+resource['id'].to_s
      record = ActiveRecord::Base.connection.exec_query sql
      return record.first['count']
    end

    def self.get_last_child_record_count(resource)
      sql = "
        select
          count(g2.*)
        from sales_distribution_resources r1
        join sales_distribution_resource_users u1 on r1.id = u1.resource_id and r1.user_id != u1.user_id
        join sales_distribution_resources g1 on u1.user_id = g1.user_id and r1.object_id = g1.object_id and r1.object_type = g1.object_type
        join sales_distribution_resource_users u2 on g1.id = u2.resource_id and g1.user_id != u2.user_id
        join sales_distribution_resources g2 on u2.user_id = g2.user_id and g1.object_id = g2.object_id and g1.object_type = g2.object_type
        where r1.id = "+resource['id'].to_s
      record = ActiveRecord::Base.connection.exec_query sql
      return record.first['count']
    end

    def self.get_visit_count(record)
      return Tracker::Visit.where("url like ?", ['%', record.url].join).where(resource: record.object).count
    end

  end
end
