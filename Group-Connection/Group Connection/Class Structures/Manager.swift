//
//  Manager.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 1/31/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Manager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCAdvertiserAssistantDelegate {
    
    
    
    
        public let peerid = MCPeerID(displayName: Globals.globals.user.fullName)
//
        public var session: MCSession!
//
        public var advertisementAssistant: MCAdvertiserAssistant!
    
    override init(){
        
        super.init()
        
        session = MCSession(peer: MCPeerID(displayName: Globals.globals.user.fullName), securityIdentity: nil, encryptionPreference: .none)
        
        session.delegate = self
        

        
    }
    
    public func advertisementHandler(code: String) {
        
        //advertisementAssistant = MCAdvertiserAssistant(serviceType: Globals.globals.passingData.0, discoveryInfo: ["Group Name": Globals.globals.passingData.1, "Event Name": Globals.globals.passingData.2, "Full Name": Globals.globals.passingData.3, "Discription": Globals.globals.passingData.4 ], session: Globals.globals.session)
        advertisementAssistant = MCAdvertiserAssistant(serviceType: code, discoveryInfo: nil, session: Globals.globals.manager.session)
        //advertisementAssistant.delegate = Globals.globals.manager
        print("delegate setup")
        print("Access Code: " + code)
        advertisementAssistant.start()
        print("Advertising Started")
        
    
        
        
    }
    
    
    //Delagate Stuff
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState){
        
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            print(MCSessionState.self)
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            print(MCSessionState.self)
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
            print(MCSessionState.self)
        }
        
    }
    
    // Received data from remote peer.
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID){
        do {
            /*print("Recieved Data")
            let sentData = try JSONDecoder().decode( Tuple.self, from: data)
            print(sentData)
            
            switch(sentData.0){
                
                case "check":
                    print("check")
                
                case "panic":
                    print("panic")
                
                
                default:
                    print(sentData.0 + " is not recognized yet")
                
            }
            
            
            
            */
        }
        catch {
            
        }
    }
    
    func session (_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler (true)
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
    
    //Service Browser Delagate stuff
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        
        
        
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
        
    }
    
    
    public func advertiserAssistantWillPresentInvitation(_ advertiserAssistant: MCAdvertiserAssistant){
        
        
        
    }
    
    
    // An invitation was dismissed from screen.
    public func advertiserAssistantDidDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant){
        
        
        
        
    }
}




