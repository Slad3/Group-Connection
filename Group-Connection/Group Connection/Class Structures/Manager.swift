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
        
        session = MCSession(peer: peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        session.delegate = Manager()
        
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
    
    public func setupSession(){
        
//        session = MCSession(peer: peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
//        session.delegate = Manager()
        
    }
    
    
    
    public func receivedCheck(check1: Check) {
        Check.receiveCheck(check: check1)
    }
    
    
    
    public func receivedPanic() {
        
        do {
            let content = UNMutableNotificationContent()
            content.title = "PANIC"
            content.subtitle = "USER *INSERT USER* HAS PANICED"
            //content.sound = UNNotificationSound.init(named: "Surprise Motherfcker Sound Effect ORIGINAL.mp3")
            content.badge = 31
            content.categoryIdentifier = "panic"
            let identifier = "panic"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            let data = try JSONEncoder().encode("panic")
            let mentors = Globals.getIDs(Globals.globals.getMentors())
            try Globals.globals.manager.session.send(data, toPeers: mentors, with: .reliable)
            print("triggered")
        }
        catch {
            print("panicking failed")
        }
        
        
        
        
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
            //var sentData = try JSONDecoder().decode(Present.self, from: data)
            var sentData = try JSONDecoder().decode(String.self, from: data)
            print(sentData)
            
            switch(sentData){
                
                case "check":
                    print("check received " + sentData)
                    //receivedCheck(check1: sentData.check)
                
                case "panic":
                    print("panic received " + sentData)
                    //receivedPanic()
                
                default:
                    print(" is not recognized yet")
                
            }
        }
        catch{
            print("asdf")
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
