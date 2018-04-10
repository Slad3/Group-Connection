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
    
    public let session = MCSession(peer: MCPeerID(displayName: Globals.globals.user.fullName), securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
    
    
    override init(){
        
        
    }
    
    
    //Delagate Stuff
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState){
        
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
            let temp = try JSONDecoder().decode(String.self, from: data)
            print(temp)
            
            
            
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




