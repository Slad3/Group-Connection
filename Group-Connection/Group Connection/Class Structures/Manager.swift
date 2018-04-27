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
import UserNotifications

class Manager: NSObject, MCSessionDelegate, MCAdvertiserAssistantDelegate {
    
    
    
    
    public var session: MCSession!
    var advertisementAssistant: MCAdvertiserAssistant!
    let peerid = MCPeerID(displayName: Globals.globals.user.fullName)
    
    
    
    override init(){
        super.init()
        session = MCSession(peer: peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        print("set session")
        session.delegate = self
        print("set delegate")
        
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
    
    
    
    public func receivedCheck(check1: Check) {
        Check.receiveCheck(check: check1)
    }
    
    
    
    public func receivedPanic(peer: MCPeerID) {
        
        do {
            let content = UNMutableNotificationContent()
            content.title = "PANIC"
            content.subtitle = "USER " + peer.displayName + " HAS PANICED"
            //content.sound = UNNotificationSound.init(named: "Surprise Motherfcker Sound Effect ORIGINAL.mp3")
            content.badge = 31
            content.categoryIdentifier = "panic"
            let identifier = "panic"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
        
        
        
    }
    
    
    
    //Delagate Stuff
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState){
        print("Got to connection state")
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
            //var sentData1: Present! = try Present(data: data, encoding: .utf8)
            //var sentData: String! = try String(data: data, encoding: .utf8)//String(data, .utf8)
            var sentData: Present! = try JSONDecoder().decode(Present.self, from: data)
            print(sentData.identifier)
            
            switch(sentData.identifier){
                
                case "check":
                    print("check received " + sentData.identifier)
                    receivedCheck(check1: sentData.check)
                
                case "panic":
                    print("panic received " + sentData.identifier)
                    receivedPanic(peer: peerID)
                
                default:
                    print(" is not recognized yet")
                
            }
        }
        catch{
            print("Decoding Encoded message failed")
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
