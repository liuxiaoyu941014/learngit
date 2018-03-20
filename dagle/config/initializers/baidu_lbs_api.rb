config = Rails.application.config_for(:baidu_lbs_api)['geocoding']
BaiduApi::Geocoding.setup ak: config['ak'], sk: config['sk']
