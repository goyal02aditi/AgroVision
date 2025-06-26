#!/usr/bin/env python3
import http.server
import socketserver
import os
from pathlib import Path

# Set the port
PORT = 5000

# Set the directory to serve files from
WEB_DIR = "web"

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_DIR, **kwargs)
    
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def main():
    # Ensure web directory exists
    os.makedirs(WEB_DIR, exist_ok=True)
    
    # Create server
    with socketserver.TCPServer(("0.0.0.0", PORT), MyHTTPRequestHandler) as httpd:
        print(f"AgroVision server running at http://0.0.0.0:{PORT}")
        print(f"Serving files from ./{WEB_DIR} directory")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped.")

if __name__ == "__main__":
    main()