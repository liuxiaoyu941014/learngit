<template>
  <div class="login-box">
    <h1 class="title">{{title}}</h1>
    <div v-if="loginResult.user && !loginResult.newUser">
      <h3 class="headshot"><img :src="loginResult.user.image"></h3>
      <h3 class="username">{{loginResult.user.name}}</h3>
      <div class="row logged-in">
        <div class="col-md-6">
          <button class="btn btn-primary btn-block" @click="keepCurrentLogin">当前用户登录</button>
        </div>
        <div class="col-md-6">
          <button class="btn btn-info btn-block" @click="newUserLogin">其他帐号登录</button>
        </div>
      </div>
    </div>
    <div v-else>
      <form v-if="enabledPasswordLogin && isPasswordLogin" @submit="loginWithPassword" class="form">
        <div class="form-group" :class="{ 'has-error': errors.login }">
          <input ref="loginInput" v-model="userPassAuth.login" class="form-control login" placeholder="用户名/EMAIL/手机号">
          <span class="help-block">{{errors.login}}</span>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.password }">
          <input ref="passwordInput" type="password" v-model="userPassAuth.password" class="form-control password" placeholder="密码">
          <span class="help-block">{{errors.password}}</span>
        </div>
        <div class="form-group">
          <label style="font-weight: normal">
            <input type="checkbox" v-model="agreementChecked">  我已阅读并同意
          </label>
          <a :href="agreementUrl" target="_blank">用户协议</a> 和 <a :href="privacyUrl" target="_blank">隐私条款</a>.
        </div>
        <div class="row">
          <div :class="`col-md-${ registerUrl ? 6 : 12 }`">
            <button type="submit" class="btn btn-primary btn-block" :disabled="!userPassAuth.password || !userPassAuth.login || !agreementChecked">登录</button>
          </div>
          <div class="col-md-6" v-if="registerUrl">
            <a :href="registerUrl" class="btn btn-success btn-block">注册</a>
          </div>
        </div>
        <p class="login-error password-login-error">{{errors.passwordLogin}}</p>
      </form>

      <form v-if="enabledMobileLogin && isMobileLogin" @submit="loginWithMobile" class="form">
        <div class="form-group" :class="{ 'has-error': errors.mobile }">
          <div class="input-group">
            <span class="input-group-addon">手机号</span>
            <input ref="mobileInput" v-model="mobileAuth.mobile" class="form-control mobile" placeholder="手机号" :disabled="mobileAuth.sentCode || isMobileInputDisabled">
          </div>
          <span class="help-block">{{errors.mobile}}</span>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.mobileCode }">
          <div class="input-group">
            <input ref="mobileCodeInput" v-model="mobileAuth.code" class="form-control mobile_code" placeholder="验证码" autocomplete="false">
            <span class="input-group-btn">
              <span v-if="mobileAuth.sentCode" class="btn btn-default">{{mobileAuth.reSendAfter}}秒后重发</span>
              <button v-else class="btn btn-default" @click="sendMobileCode" :disabled="!isValidMobile || isMobileCodeButtonDisabled">获取验证码</button>
            </span>
          </div>
          <span class="help-block">{{errors.mobileCode}}</span>
        </div>
        <div class="form-group">
          <label style="font-weight: normal">
            <input type="checkbox" v-model="agreementChecked">  我已阅读并同意
          </label>
          <a :href="agreementUrl" target="_blank">用户协议</a> 和 <a :href="privacyUrl" target="_blank">隐私条款</a>.
        </div>
        <div class="row">
          <div :class="`col-md-${ registerUrl ? 8 : 12 }`">
            <button type="submit" class="btn btn-primary btn-block" :disabled="!isValidMobileCode || !agreementChecked">登录</button>
          </div>
          <div class="col-md-4" v-if="registerUrl">
            <a :href="registerUrl" class="btn btn-success btn-block">注册</a>
          </div>
        </div>
        <p v-if="mobileAuth.sendCodeMessage" class="mobile-send-code-message">{{mobileAuth.sendCodeMessage}}</p>
        <p class="login-error mobile-login-error">{{errors.mobileLogin}}</p>
      </form>
      <template v-if="hasMultiLoginTypes">
        <div class="third-login-title">
          <span>其他登录方式</span>
        </div>
        <div class="row login-type-container">
          <div :class="`col-md-offset-${(loginTypeCount % 2) * 3}`" class="col-md-6 col-sm-12" v-if="enabledMobileLogin || enabledPasswordLogin">
            <span class="btn btn-default btn-block" v-if="enabledMobileLogin && !isMobileLogin" @click="setMobileLogin">
              <i class="fa fa-mobile" aria-hidden="true"> 手机验证</i>
            </span>
            <span class="btn btn-default btn-block" v-if="enabledPasswordLogin && !isPasswordLogin" @click="setPasswordLogin">
              <i class="fa fa-key" aria-hidden="true"> 帐号密码</i>
            </span>
          </div>
          <div class="col-md-6 col-sm-12" v-if="gitlabLoginUrl">
            <a :href="gitlabLoginUrlNoCache" class="btn btn-default btn-block"><i class="fa fa-gitlab" aria-hidden="true"> Gitlab</i></a>
          </div>
          <div class="col-md-6 col-sm-12" v-if="wechatAppid">
            <span class="btn btn-default btn-block"><i class="fa fa-wechat" aria-hidden="true"> 微信</i></span>
          </div>
        </div>
      </template>
    </div>
  </div>
</template>

<script>
import SessionsService from 'services/sessions_service'
import { returnBackAfterSignin } from '../utils'
export default {
  props: {
    enablePasswordLogin: { default: false },
    enableMobileLogin: { default: false },
    defaultLoginType: { default: 'mobile' },
    loginUrl: { required: true },
    registerUrl: [String],
    gitlabLoginUrl: [String],
    wechatAppid: [String],
    title: { default: '通用登录' },
    urlOnSuccess: { required: true },
    agreementUrl: { default: '/pages/agreement' },
    privacyUrl: { default: '/pages/privacy' }
  },
  data () {
    return {
      loginType: 'password',
      isMobileCodeButtonDisabled: false,
      isMobileInputDisabled: false,
      agreementChecked: true,
      errors: {},
      loginResult: {
        user: null,
        token: null,
        newUser: false
      },
      userPassAuth: {
        login: '',
        password: ''
      },
      mobileAuth: {
        mobile: '',
        code: '',
        sentCode: false,
        reSendAfter: 0,
        sendCodeMessage: ''
      }
    }
  },
  computed: {
    loginTypeCount () {
      var i = 0;
      if (this.enabledPasswordLogin) i++;
      if (this.enabledGitlabLogin) i++;
      if (this.enabledWxmpLogin) i++;
      return i;
    },
    enabledPasswordLogin () {
      return this.enablePasswordLogin === 'true'
    },
    enabledMobileLogin () {
      return this.enableMobileLogin === 'true'
    },
    enabledGitlabLogin () {
      return !!this.gitlabLoginUrl
    },
    enabledWxmpLogin () {
      return !!this.wechatAppid
    },
    isPasswordLogin () {
      return this.loginType === 'password'
    },
    isMobileLogin () {
      return this.loginType === 'mobile'
    },
    isValidMobile () {
      return this.mobileAuth.mobile.match(/^\s*1\d{10}\s*$/)
    },
    isValidMobileCode () {
      return this.isValidMobile && this.mobileAuth.code
    },
    hasMultiLoginTypes () {
      let i = 0;
      if(this.enabledPasswordLogin) i++
      if(this.enabledMobileLogin) i++
      if(this.enabledGitlabLogin) i++
      if(this.enabledWxmpLogin) i++
      return i > 1
    },
    // 链接不加时间唯一性，会导致Safari请求链接多次
    gitlabLoginUrlNoCache () {
      if (this.gitlabLoginUrl.indexOf('?') >= 0){
        return `${this.gitlabLoginUrl}&_t=${new Date() - 0}`
      } else {
        return `${this.gitlabLoginUrl}?_t=${new Date() - 0}`
      }
    }
  },
  methods: {
    setPasswordLogin () {
      this.loginType = 'password';
      this.$nextTick(() => {
        this.$refs.loginInput.focus()
      });
    },
    setMobileLogin () {
      this.loginType = 'mobile';
      this.$nextTick(() => {
        this.$refs.mobileInput.focus()
      });
    },
    keepCurrentLogin () {
      returnBackAfterSignin(this.urlOnSuccess)
    },
    loginWithPassword (e) {
      e.preventDefault()
      var { login, password } = this.userPassAuth
      this.errors = {}
      if (login.trim().length === 0) {
        this.errors.login = '请输入登录帐号'
        this.$refs.loginInput.focus()
      }
      if (password.trim().length === 0) {
        this.errors.password = '请输入密码'
        if (!this.errors.login)
          this.$refs.passwordInput.focus()
      }
      if (this.errors.login || this.errors.password) return;
      SessionsService.loginWithPassword(login, password).then((response) => {
        let result = response.data;
        switch(result.code_name) {
          case 'success':
            // this.loginWithToken(result.data.token)
            returnBackAfterSignin(this.urlOnSuccess)
            break;
          case 'login_user_not_found':
            this.$set(this.errors, 'login', result.message)
            this.$refs.loginInput.focus()
            break;
          case 'invalid_password':
            this.$set(this.errors, 'password', result.message)
            this.$refs.passwordInput.focus()
            break
          default:
            alert(result.message);
        }
      }).catch((error) => {
        this.errors.passwordLogin = error.message;
      })
    },
    loginWithMobile (e) {
      e.preventDefault();
      if(!this.isValidMobile || !this.isValidMobileCode) return
      this.mobileAuth.sendCodeMessage = ''
      SessionsService.loginWithMobile(this.mobileAuth.mobile, this.mobileAuth.code).then((resp) => {
        switch(resp.data.code_name) {
          case 'success':
            // this.loginWithToken(resp.data.data.token);
            returnBackAfterSignin(this.urlOnSuccess)
            break;
          default:
            this.$set(this.errors, 'mobileLogin', resp.data.message);
            break;
        }
      }).catch((resp) => {
        this.$set(this.errors, 'mobileLogin', resp.message);
      })
    },
    // loginWithUrlToken () {
    //   if (!window.location.search) return;
    //   var token_pair = window.location.search.substring(1).split('&').map((part) => part.split('=')).find((pair) => pair[0] === 'tanmer_auth_token')
    //   if (token_pair) {
    //     this.loginWithToken(token_pair[1])
    //   }
    // },
    sendMobileCode () {
      this.errors = {}
      this.isMobileCodeButtonDisabled = true
      this.isMobileInputDisabled = true
      SessionsService.sendSmsAuthCode(this.mobileAuth.mobile).then((resp) => {
        switch (resp.data.code_name) {
          case 'success':
            this.mobileAuth.sentCode = true;
            this.mobileAuth.reSendAfter = 120;
            this.countDownReSendAfter();
            this.$refs.mobileCodeInput.focus();
            this.mobileAuth.sendCodeMessage = resp.data.message;
            break;
          case 'login_user_not_found':
            this.$set(this.errors, 'mobile', '手机号不存在');
            this.isMobileCodeButtonDisabled = false
            this.isMobileInputDisabled = false
            break;
          default:
            this.$set(this.errors, 'mobileLogin', resp.data.message);
            this.isMobileCodeButtonDisabled = false
            this.isMobileInputDisabled = false
            break;
        }
      }).catch((resp) => {
        this.$set(this.errors, 'mobileLogin', resp.message);
        this.isMobileCodeButtonDisabled = false
        this.isMobileInputDisabled = false
      })
    },
    countDownReSendAfter () {
      if (this.mobileAuth.reSendAfter > 1) {
        this.$set(this.mobileAuth, 'reSendAfter', this.mobileAuth.reSendAfter - 1);
        setTimeout(this.countDownReSendAfter.bind(this), 1000);
      } else {
        this.$set(this.mobileAuth, 'reSendAfter', 0);
        this.$set(this.mobileAuth, 'code', '');
        this.$set(this.mobileAuth, 'sentCode', false);
        this.isMobileCodeButtonDisabled = false;
        this.isMobileInputDisabled = false;
      }
    },
    // loginWithToken (token) {
    //   http.post(this.loginUrl, { token }).then((resp) => {
    //     var result = resp.data;
    //     if (result.code_name == 'success') {
    //       window.location.href = result.data.return_to || this.urlOnSuccess
    //     } else {
    //       this.errors.passwordLogin = '登录失败'
    //     }
    //   }).catch((resp) => {
    //     this.errors.passwordLogin = resp.message
    //   })
    // },
    // fetchTokenAndLogin () {
    //   SessionsService.getToken(this.appid).then((response) => {
    //     let r = response.data
    //     if (r.data && r.data.token) {
    //       this.loginWithToken(r.data.token)
    //     } else {
    //       this.loginResult.user = null
    //     }
    //   }).catch((resp) => {
    //     this.errors.passwordLogin = resp.message
    //   })
    // },
    newUserLogin () {
      this.loginResult.newUser = true
    }
  },
  mounted () {
    this.loginType = this.defaultLoginType
    if(!this.loginType){
      if(this.enabledMobileLogin){
        this.loginType = 'mobile'
      } else if(this.enabledPasswordLogin) {
        this.loginType = 'password'
      }
    }
    // this.loginWithUrlToken();
    setTimeout(() => {
      SessionsService.status().then((response) => {
        let r = response.data
        if (r.code === 0 && r.data.user) {
          this.$set(this.loginResult, 'user', r.data.user)
        }
      }).catch((error) => {
        console.log('error', error)
      })
    }, 100)
  }
}
</script>

<style lang="scss" scoped>

h3.username, h3.headshot {
  text-align: center;
}

.row.logged-in {
  margin-top: 40px;
}

.login-message {
  text-align: center;
  margin-top: 20px;
  margin-bottom: 20px;
  color: red;
}

.mobile-send-code-message {
  margin: 20px;
  color: green;
  text-align: center;
}

.login-error {
  margin: 20px;
  color: red;
  text-align: center;
}

.third-login-title {
  text-align: center;
  position: relative;
  margin-top: 20px;
  margin-bottom: 20px;
  &:after {
    position: absolute;
    content: '';
    width: 100%;
    height: 1px;
    left: 0;
    right: 0;
    top: 50%;
    z-index: 1;
    background-color: rgb(150, 150, 150);
  }
  > span {
    background-color: #FFF;
    color: gray;
    position: relative;
    z-index: 2;
    padding: 10px;
  }
}
</style>
