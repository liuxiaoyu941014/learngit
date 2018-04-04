<template>
  <div class="registration-box">
    <h1 class="title">{{title}}</h1>
    <div>
      <template v-if="hasMultiRegTypes">
        <div class="third-login-title">
          <span>用户注册</span>
        </div>

        <div class="row text-center registration-type-container">
          <div class="btn-group" role="group" aria-label="用户注册">
            <button v-if="enabledMobileReg" class="btn btn-default" @click="setMobileReg" :class="{'disabled btn-primary': enabledMobileReg && isMobileReg}">
              <i class="fa fa-mobile" aria-hidden="true"> 手机注册</i>
            </button>
            <button v-if="enabledEmailReg" class="btn btn-default" @click="setEmailReg" :class="{'disabled btn-primary': enabledEmailReg && isEmailReg}">
              <i class="fa fa-key" aria-hidden="true"> 邮箱注册</i>
            </button>
            <button v-if="enabledUsernameReg"class="btn btn-default" @click="setUsernameReg" :class="{'disabled btn-primary': enabledUsernameReg && isUsernameReg}">
              <i class="fa fa-key" aria-hidden="true"> 用户名注册</i>
            </button>
          </div>
        </div>
        <br/>
      </template>
      <form v-if="enabledEmailReg && isEmailReg" @submit="regWithEmail" class="form">
        <div class="form-group" :class="{ 'has-error': errors.login }">
          <input ref="emailInput" v-model="userEmailReg.email" class="form-control login" placeholder="电子邮件">
          <span class="help-block">{{errors.login}}</span>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.password }">
          <input ref="passwordInput" type="password" v-model="userEmailReg.password" class="form-control password" placeholder="密码">
          <span class="help-block">{{errors.password}}</span>
        </div>
        <div class="form-group">
          <label style="font-weight: normal">
            <input type="checkbox" v-model="agreementChecked">  我已阅读并同意
          </label>
          <a :href="agreementUrl" target="_blank">用户协议</a> 和 <a :href="privacyUrl" target="_blank">隐私条款</a>.
        </div>
        <div class="row">
          <div class="col-md-8">
            <button type="submit" class="btn btn-primary btn-block" :disabled="!userEmailReg.email || !userEmailReg.password || !agreementChecked">提交注册</button>
          </div>
          <div class="col-md-4">
            <a :href="loginUrl" class="btn btn-default btn-block">登录</a>
          </div>
        </div>
        <p class="login-error email-login-error">{{errors.emailLogin}}</p>
      </form>
      <form v-if="enabledUsernameReg && isUsernameReg" @submit="regWithUsername" class="form">
        <div class="form-group" :class="{ 'has-error': errors.login }">
          <input ref="usernameInput" v-model="usernameReg.username" class="form-control login" placeholder="用户名">
          <span class="help-block">{{errors.login}}</span>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.password }">
          <input ref="passwordInput" type="password" v-model="usernameReg.password" class="form-control password" placeholder="密码">
          <span class="help-block">{{errors.password}}</span>
        </div>
        <div class="form-group">
          <label style="font-weight: normal">
            <input type="checkbox" v-model="agreementChecked">  我已阅读并同意
          </label>
          <a :href="agreementUrl" target="_blank">用户协议</a> 和 <a :href="privacyUrl" target="_blank">隐私条款</a>.
        </div>
        <div class="row">
          <div class="col-md-8 col-sm-8">
            <button type="submit" class="btn btn-primary btn-block" :disabled="!usernameReg.username || !usernameReg.password || !agreementChecked">提交注册</button>
          </div>
          <div class="col-md-4 col-sm-4">
            <a :href="loginUrl" class="btn btn-default btn-block">登录</a>
          </div>
        </div>
        <p class="login-error email-login-error">{{errors.emailLogin}}</p>
      </form>

      <form v-if="enabledMobileReg && isMobileReg" @submit="regWithMobile" class="form">
        <div class="form-group" :class="{ 'has-error': errors.mobile }">
          <div class="input-group">
            <span class="input-group-addon">手机号</span>
            <input ref="mobileInput" v-model="mobileReg.mobile" class="form-control mobile" placeholder="手机号" :disabled="mobileReg.sentCode || isMobileInputDisabled">
          </div>
          <span class="help-block">{{errors.mobile}}</span>
        </div>
        <div class="form-group" :class="{ 'has-error': errors.mobileCode }">
          <div class="input-group">
            <input ref="mobileCodeInput" v-model="mobileReg.code" class="form-control mobile_code" placeholder="验证码" autocomplete="false">
            <span class="input-group-btn">
              <span v-if="mobileReg.sentCode" class="btn btn-default">{{mobileReg.reSendAfter}}秒后重发</span>
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
          <div class="col-md-8">
            <button type="submit" class="btn btn-primary btn-block" :disabled="!isValidMobileCode || !agreementChecked">提交注册</button>
          </div>
          <div class="col-md-4">
            <a :href="loginUrl" class="btn btn-default btn-block">登录</a>
          </div>
        </div>
        <p v-if="mobileReg.sendCodeMessage" class="mobile-send-code-message">{{mobileReg.sendCodeMessage}}</p>
        <p class="login-error mobile-login-error">{{errors.mobileReg}}</p>
      </form>
    </div>
  </div>
</template>

<script>
import RegistrationService from 'services/registration_service'
import { returnBackAfterSignin } from '../utils'
export default {
  props: {
    title: { default: '通用登录' },
    defaultRegType: { default: 'mobile' },
    enableMobileReg: { default: false },
    enableEmailReg: { default: false },
    enableUsernameReg: { default: false },
    smsAuthCodeLength: { default: 4 },
    loginUrl: { required: true },
    agreementUrl: { default: '/pages/agreement' },
    privacyUrl: { default: '/pages/privacy' }
  },
  data () {
    return {
      regType: '',
      checked: true,
      isMobileCodeButtonDisabled: false,
      isMobileInputDisabled: false,
      agreementChecked: true,
      errors: {},
      usernameReg: {
        username: '',
        password: '',
        passwordConfirm: '',
      },
      userEmailReg: {
        email: '',
        code: '',
        password: '',
        passwordConfirm: '',
      },
      mobileReg: {
        mobile: '',
        code: '',
        sentCode: false,
        reSendAfter: 0,
        sendCodeMessage: ''
      }
    }
  },
  computed: {
    enabledEmailReg () {
      return this.enableEmailReg === 'true'
    },
    enabledMobileReg () {
      return this.enableMobileReg === 'true'
    },
    enabledUsernameReg () {
      return this.enableUsernameReg === 'true'
    },
    isMobileReg () {
      return this.regType === 'mobile'
    },
    isEmailReg () {
      return this.regType === 'email'
    },
    isUsernameReg () {
      return this.regType === 'username'
    },
    isValidMobile () {
      return this.mobileReg.mobile.match(/^\s*1\d{10}\s*$/)
    },
    isValidMobileCode () {
      return this.isValidMobile && this.mobileReg.code && this.mobileReg.code.length == this.smsAuthCodeLength
    },
    hasMultiRegTypes () {
      let i = 0;
      if(this.enabledEmailReg) i++
      if(this.enabledMobileReg) i++
      if(this.enabledUsernameReg) i++
      return i > 1
    }
  },
  methods: {
    setMobileReg () {
      this.regType = 'mobile';
      this.$nextTick(() => {
        this.$refs.mobileInput.focus()
      });
    },
    setEmailReg () {
      this.regType = 'email';
      this.$nextTick(() => {
        this.$refs.emailInput.focus()
      });
    },
    setUsernameReg () {
      this.regType = 'username';
      this.$nextTick(() => {
        // this.$refs.usernameInput.focus()
      });
    },
    sendMobileCode () {
      this.errors = {}
      this.isMobileCodeButtonDisabled = true
      this.isMobileInputDisabled = true
      RegistrationService.sendSmsAuthCode(this.mobileReg.mobile).then((resp) => {
        switch (resp.data.code_name) {
          case 'success':
            this.mobileReg.sentCode = true;
            this.mobileReg.reSendAfter = 120;
            this.countDownReSendAfter();
            this.$nextTick(() => this.$refs.mobileCodeInput.focus());
            this.mobileReg.sendCodeMessage = resp.data.message;
            break;
          case 'register_invalid_mobile_phone':
          case 'register_user_found':
            this.$set(this.errors, 'mobile', resp.data.message);
            this.isMobileCodeButtonDisabled = false
            this.isMobileInputDisabled = false
            this.$nextTick(() => this.$refs.mobileInput.focus());
            break;
          default:
            this.$set(this.errors, 'mobileReg', resp.data.message);
            this.isMobileCodeButtonDisabled = false
            this.isMobileInputDisabled = false
            break;
        }
      }).catch((resp) => {
        this.$set(this.errors, 'mobileReg', resp.message);
        this.isMobileCodeButtonDisabled = false
        this.isMobileInputDisabled = false
      })
    },
    countDownReSendAfter () {
      if (this.mobileReg.reSendAfter > 1) {
        this.$set(this.mobileReg, 'reSendAfter', this.mobileReg.reSendAfter - 1);
        setTimeout(this.countDownReSendAfter.bind(this), 1000);
      } else {
        this.$set(this.mobileReg, 'reSendAfter', 0);
        this.$set(this.mobileReg, 'code', '');
        this.$set(this.mobileReg, 'sentCode', false);
        this.isMobileCodeButtonDisabled = false;
        this.isMobileInputDisabled = false;
      }
    },
    regWithEmail (e) {
      e.preventDefault()
    },
    regWithUsername (e) {
      e.preventDefault()
    },
    regWithMobile (e) {
      e.preventDefault();
      if(!this.isValidMobile || !this.isValidMobileCode) return
      this.mobileReg.sendCodeMessage = ''
      RegistrationService.regWithMobile(this.mobileReg.mobile, this.mobileReg.code).then((resp) => {
        switch(resp.data.code_name) {
          case 'success':
            // this.loginWithToken(resp.data.data.token);
            returnBackAfterSignin(this.urlOnSuccess)
            break;
          default:
            this.$set(this.errors, 'mobileReg', resp.data.message);
            break;
        }
      }).catch((resp) => {
        this.$set(this.errors, 'mobileReg', resp.message);
      })
    }
  },
  mounted () {
    this.regType = this.defaultRegType
    if(!this.regType){
      if(this.enabledMobileReg){
        this.regType = 'mobile'
      } else if(this.enabledEmailReg) {
        this.regType = 'email'
      } else if(this.enabledUsernameReg) {
        this.regType = 'username'
      }
    }
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
