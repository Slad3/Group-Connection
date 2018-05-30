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


class Manager: NSObject, MCSessionDelegate, MCAdvertiserAssistantDelegate, MCNearbyServiceAdvertiserDelegate {
    
    
    public var session: MCSession!
    var advertisementAssistant: MCAdvertiserAssistant!
    let peerid = MCPeerID(displayName: Globals.globals.user.fullName)
    var until: Progress!
    
    
    
    override init(){
        super.init()
        session = MCSession(peer: peerid, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        print("set session")
        session.delegate = self
        print("set delegate")
        until = Progress()
        
    }
    
    //For making and starting advertisment system
    public func advertisementHandler(code: String) {
        var service = false
        
        if (service){//Advertising using the Nearby Service Advertiser
            
            let serviceNearby = MCNearbyServiceAdvertiser(peer: Globals.globals.manager.peerid, discoveryInfo: ["Group Name": Globals.globals.passingData.1, "Event Name": Globals.globals.passingData.2, "Full Name": Globals.globals.passingData.3, "Discription": Globals.globals.passingData.4], serviceType: code)
            
            print("Access Code: " + code)
            serviceNearby.delegate = self
            print("Delegate Setup")
            serviceNearby.startAdvertisingPeer()
            print("Advertising Started")
            
        }
        else {//Advertising using the Advertisement Assistant
            
            advertisementAssistant = MCAdvertiserAssistant(serviceType: code, discoveryInfo: ["Group Name": Globals.globals.passingData.1, "Event Name": Globals.globals.passingData.2, "Full Name": Globals.globals.passingData.3, "Discription": Globals.globals.passingData.4], session: Globals.globals.manager.session)
            
            print("Access Code: " + code)
            advertisementAssistant.delegate = self
            print("Delegate setup")
            advertisementAssistant.start()
            print("Advertising Started")
        }
    }
    
    
    //Receiving Check
    public func receivedCheck(check1: Check) {
        Check.receiveCheck(check: check1)
    }
    
    
    //Receiving Panic
    public func receivedPanic(panic: Panic) {
        
        do {
            let content = UNMutableNotificationContent()
            content.title = "PANIC"
            content.subtitle = "USER " + panic.sender.fullName + " HAS PANICED"
            //content.sound = UNNotificationSound.init(named: "Surprise Motherfcker Sound Effect ORIGINAL.mp3")
            content.badge = 31
            content.categoryIdentifier = "panic"
            let identifier = "panic"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            //Add code to add user on the map here
            
            
            
            
        }
        catch {
            print("panicking failed")
        }
    }
    
    
    
    //All Delagate Stuff
    
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
            var sentData: Present.present! = try JSONDecoder().decode(Present.present.self, from: data)
            let actualPresent = Present(present: sentData)
            print(actualPresent.identifier)
            
            
            //Switch is based on the identifier of the Present
            switch(actualPresent.identifier){
                
            case "check":
                print("check received " + actualPresent.identifier)
                receivedCheck(check1: actualPresent.check)
                break
                
            case "panic":
                print("panic received " + actualPresent.identifier)
                receivedPanic(panic: actualPresent.panic)
                break
                
            case "Send Initial Check":
                print("Connected to session. Received Initial Check")
                Globals.globals.event.competitionRoster.append(actualPresent.check.sender)
                var lamp = Present(ident: "Send Event", evant: Globals.globals.event)
                Globals.sendData(message: lamp, toPeer: peerID)
                print("sent something")
                //                    var fileURL = URL(fileURLWithPath: Globals.globals.documentsDirectory.relativePath, isDirectory: true)
                //                    print(Globals.globals.importedMapName)
                //                    Globals.globals.manager.session.sendResource(at: fileURL, withName: Globals.globals.importedMapName, toPeer: peerID, withCompletionHandler: nil)
                print("Sent event and inital data")
                break
                
            case "Send Event":
                print("Receiving event")
                Globals.globals.event = actualPresent.event
                print(actualPresent.identifier)
                Globals.globals.receivedEvent = true
                print("Received Event")
                
                break
                
            case "Update Event Request":
                print("Update Event Request")
                var clock = Present(ident: "Update Event", evant: Globals.globals.event)
                Globals.sendData(message: clock, toPeer: peerID)
                break
                
            case "Update Event":
                print("Update Event")
                Globals.globals.event.updateEvent(new: actualPresent.event)
                break
                
            default:
                print(" is not recognized yet")
                break
                
            }
        }
        catch{
            print("Decoding Encoded message failed")
        }
        
    }
    
    
    //Did receive invite to join from someone
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Found peer")
        //Accept invite
        invitationHandler(true, Globals.globals.manager.session)
        
        //Send Initial Event Stuff
        print("Sending invited peer starting files")
        //Change this to sending Event class once event class becomes D/Encodable
        //Globals.sendData(message: Present(ident: "initialCheck"))
        
    }
    
    // Received a byte stream from remote peer.
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID){
        
    }
    
    // Start receiving a resource from remote peer.
    @available(iOS 11.0, *)
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress){
        until = progress
        print("Receiving Resource")
        while(!progress.isFinished){
            print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm")
            print(progress.completedUnitCount/progress.totalUnitCount)
            
        }
    }
    
    // Finished receiving a resource from remote peer and saved the content
    // in a temporary location - the app is responsible for moving the file
    // to a permanent location within its sandbox.
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?){
        switch(resourceName){
        case "importedMap":
            print("got imported map")
            var chair: Person = Globals.globals.event.findPerson(name: peerID.displayName)
            let destinationURL: URL = Globals.globals.documentsDirectory
            do {
                try FileManager.default.moveItem(at: localURL!, to: destinationURL)
                print("Finished receiving resource")
                try Globals.globals.importedMap = UIImage(named: resourceName)
                try Globals.globals.compressedMap = Globals.globals.compressImage(image: Globals.globals.importedMap)
                print("Done setting imported map")
            } catch {
                print("[Error] \(error)")
            }
            break
            
            
        case "Profile Image":
            print(resourceName)
            var chair: Person = Globals.globals.event.findPerson(name: peerID.displayName)
            let destinationURL: URL = Globals.globals.documentsDirectory
            do {
                try FileManager.default.moveItem(at: localURL!, to: destinationURL)
                print("Finished receiving resource")
                //try chair.profilePhoto = UIImage(named: resourceName)
                print("Done Set profile photo")
            } catch {
                print("[Error] \(error)")
            }
            break
            
        default:
            print("Unidentified Resource")
            break
            
        }
        
        
    }
    
    
}
