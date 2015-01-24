run -> (env) {
  if env[:REQUEST_PATH] = '/'
    body = ['You requested index. Success!']
  end
  [200, {}, body ||= []]
}