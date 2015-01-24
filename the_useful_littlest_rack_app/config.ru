run -> (env) {
  body = "<html><body><h1>Hello, world!</h1></body></html>"
  headers = { 'Content-Length' => body.length.to_s }
  [200, headers, [body]]
}