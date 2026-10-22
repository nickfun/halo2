(import tester :prefix "" :exit true)
(import ../src/halo2 :prefix "")

# make sure tester is installed before running these tests

(deftests
  (test "response"
    (is (deep= "HTTP/1.1 200 OK\r\nContent-Length: 4\r\nContent-Type: text/plain\r\n\r\ntest"
               (http-response {:status 200
                               :headers {"Content-Type" "text/plain"}
                               :body "test"}))))

  (test "response with headers of list"
    (is (deep= "HTTP/1.1 200 OK\r\nX-1: one\r\nX-1: two\r\nContent-Length: 4\r\n\r\ntest"
               (http-response {:status 200
                               :headers {"X-1" ["one" "two"]}
                               :body "test"}))))
  
  (test "response with headers of list with others"
    (is (deep= "HTTP/1.1 200 OK\r\nZ: zed\r\nX-1: one\r\nX-1: two\r\nContent-Length: 4\r\nA: alpha\r\n\r\ntest"
               (http-response {:status 200
                               :headers {"A" "alpha" "X-1" ["one" "two"] "Z" ["zed"]}
                               :body "test"}))))

  (test "request peg"
    (is (deep= @{:http-version "1.1"
                 :headers @{"Content-Type" "text/plain"}
                 :uri "/"
                 :path "/"
                 :method "GET"}
               (request @"GET / HTTP/1.1\r\nContent-Type: text/plain\r\n\r\n")))))
