export function returnBackAfterSignin(defaultBackTo){
  var url = new URL(window.location.href)
  window.location.href = url.searchParams.get('return_to') || defaultBackTo || '/'
}
