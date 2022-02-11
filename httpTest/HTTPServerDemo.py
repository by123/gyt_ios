import BaseHTTPServer
import urlparse, urllib, json
from mobileservice import *

class WebRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):


     def do_POST(self):
         mpath,margs=urllib.splitquery(self.path)
         datas = self.rfile.read(int(self.headers['content-length']))
         requestIPAddress = self.client_address
         decodeJson = json.loads(datas)
         rpcname = decodeJson["rpcname"]
         rpcparams = decodeJson["rpcparams"]
         if rpcname == "login":
            rpcparams["request_IP"] = requestIPAddress
            print rpcparams
            response = call(rpcname, rpcparams)
            #sessionId = response["response"]["sessionId"]
            #print sessionId
         else:
            print rpcparams
            response = call(rpcname, rpcparams)
         print mpath, margs, datas
         print response
         print type(response)
         response = json.dumps(response)
         print response
         self.protocal_version = "HTTP/1.1"
         self.send_response(200)
         self.send_header("Welcome", "Contect")
         self.end_headers()
         self.wfile.write(response)


if __name__ == '__main__':
    server = BaseHTTPServer.HTTPServer(('0.0.0.0',8081), WebRequestHandler)
    server.serve_forever()
