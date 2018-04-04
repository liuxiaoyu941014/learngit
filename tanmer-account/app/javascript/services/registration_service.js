import http from './http'


function sendSmsAuthCode(mobile) {
  return http.post('/registrations/sms-auth-code.json', { mobile })
}

function regWithMobile (mobile, code) {
  return http.post('/registrations/sms-auth', { mobile, code })
}

export default {
  sendSmsAuthCode,
  regWithMobile
}
