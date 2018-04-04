import http from './http'

function loginWithPassword (login, password) {
  return http.post('/login', { login, password })
}

function status () {

  return http.get('/sessions/status', { params: { _t: +new Date()} })
}

function sendSmsAuthCode(mobile) {
  return http.post('/sessions/sms-auth-code.json', { mobile })
}

function loginWithMobile (mobile, code) {
  return http.post('/sessions/sms-auth', { mobile, code })
}

// function buildHeaders(appid) {
//   let headers = {}
//   headers[`x-appid-${appid}`] = (new Date()).getTime()
//   headers['x-login-appid'] = appid
//   return headers
// }

// function loginWithPassword (appid, login, password) {
//   return http.post('/login', { login, password }, { headers: buildHeaders(appid) })
// }
//
// function status (appid) {
//
//   return http.get('/sessions/status', { headers: buildHeaders(appid), withCredentials: true })
// }
//
// function getToken(appid) {
//   return http.get('/sessions/get-token', { headers: buildHeaders(appid), withCredentials: true })
// }
//
// function sendSmsAuthCode(appid, mobile) {
//   return http.post('/sessions/sms-auth-code.json', { mobile }, { headers: buildHeaders(appid) })
// }
//
// function loginWithMobile (appid, mobile, code) {
//   return http.post('/sessions/sms-auth', { mobile, code }, { headers: buildHeaders(appid) })
// }

export default {
  loginWithPassword,
  status,
  // getToken,
  sendSmsAuthCode,
  loginWithMobile
}
