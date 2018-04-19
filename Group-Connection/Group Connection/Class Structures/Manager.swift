//
//  Manager.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 1/31/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import CloudKit

class Manager: NSObject, MCSessionDelegate, MCAdvertiserAssistantDelegate {
    
    
    
    
        public let peerid = MCPeerID(displayName: Globals.globals.user.fullName)

        public var session: MCSession!

        public var advertisementAssistant: MCAdvertiserAssistant!
    
    override init(){
        
        super.init()
        
        session = MCSession(peer: MCPeerID(displayName: Globals.globals.user.fullName), securityIdentity: nil, encryptionPreference: MCEncryptionPreference.required)
        
        session.delegate = self
        

        
    }
    
    public func advertisementHandler(code: String) {
        
        //advertisementAssistant = MCAdvertiserAssistant(serviceType: Globals.globals.passingData.0, discoveryInfo: ["Group Name": Globals.globals.passingData.1, "Event Name": Globals.globals.passingData.2, "Full Name": Globals.globals.passingData.3, "Discription": Globals.globals.passingData.4 ], session: Globals.globals.session)
        advertisementAssistant = MCAdvertiserAssistant(serviceType: code, discoveryInfo: nil, session: Globals.globals.manager.session)
        advertisementAssistant.delegate = Globals.globals.manager
        print("delegate setup")
        print("Access Code: " + code)
        advertisementAssistant.start()
        print("Advertising Started")
        
    
        
        
    }
    
    
    //Delagate Stuff
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState){
        print("got to connection state")
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
  
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")

            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")

        }
        
    }
    
    // Received data from remote peer.
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID){
        do {
            print("Recieved Data")
            //let sentData = try JSONDecoder().decode(Present.self, from: data)
            let sentData = try JSONDecoder().decode(String.self, from: data)
            print(sentData)
            
            switch(sentData){
                
                case "check":
                    print("check received")
                
                case "panic":
                    print("panicm received")
                
                
                default:
                    print(" is not recognized yet")
                
            }
            
            
            
            
        }
        catch {
            
        }
        
    }
    
   
    
    
    // Received a byte stream from remote peer.
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID){
        
    }
    
    // Start receiving a resource from remote peer.
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress){
        
    }
    
    // Finished receiving a resource from remote peer and saved the content
    // in a temporary location - the app is responsible for moving the file
    // to a permanent location within its sandbox.
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?){
        
    }
    
}




