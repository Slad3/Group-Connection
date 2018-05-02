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
        print("seT session")
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
            let sentData: String! = try String(data: data, encoding: .utf8)
            print(sentData)
            
            switch sentData {
                case "check":
                    print("check received " + sentData)
                    //receiveCheck(check1: sentData.check)
                    break

                case "panic":
                    print("panic received " + sentData)
                    //receivePanic()
                    break
                
                case "personAdded":
                    print("new person received")
                    //receivePerson()
                    break
                
                case "personRemoved":
                    print("person will be removed")
                    //removePerson()
                    break
                
                case "changingBuddies":
                    print("changing buddies")
                    //changeBuddies()
                    break
                
                case "timerSync":
                    print("syncing timer to mentor's")
                    //syncTimer()
                    break
                
                case "alterJoinCode":
                    print("changing code to join")
                    //changeCode()
                    break
                
                default:
                    print(" is not recognized yet")
                    break
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

