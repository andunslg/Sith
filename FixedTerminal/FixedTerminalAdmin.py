from Tkinter import *
import ttk
import datetime
import serial
import threading
import time
import urllib
import urllib2


root = Tk()
count=0
ports = list()
threads=list()
moods=list()
rowIDs = {}
portNames={}
portLocations={}
eventID=""
started=False
averagePerception="None"
threshold=0
userCount=0


def addNewClient():
    addNew=Tk()
    addNew.geometry("250x250")
    addNew.title("Add new client")
    locationLabel= Label(addNew, text="Location: ")
    latLabel= Label(addNew, text="Latitude: ")
    longiLabel= Label(addNew, text="Longitude: ")
    portLabel= Label(addNew, text="Port: ")
    nameLabel= Label(addNew, text="Name:")
    location = Entry(addNew)
    lat = Entry(addNew)
    longi = Entry(addNew)
    port = Entry(addNew)
    name = Entry(addNew)
    button1=Button(addNew,
      text="Add",command=lambda: addNewOkPressed(location,port,name,lat,longi))
    nameLabel.pack()
    name.pack()
    portLabel.pack()
    port.pack()
    locationLabel.pack()
    location.pack()
    latLabel.pack()
    lat.pack()
    longiLabel.pack()
    longi.pack()    
    button1.pack()

def configureEvent():
    eventConfig=Tk()
    eventConfig.title("Configure event")
    configureModes=list()
    buttonLabelEventID=Label(eventConfig,text="EventID:")
    butonEventID=Entry(eventConfig)
    buttonLabelThreshold=Label(eventConfig,text="User count:")
    butonThreshold=Entry(eventConfig)
    buttonLabel1=Label(eventConfig,text="Perception 1:")
    butonMode1=Entry(eventConfig)
    configureModes.append(butonMode1)
    buttonLabel2=Label(eventConfig,text="Perception 2:")
    butonMode2=Entry(eventConfig)
    configureModes.append(butonMode2)
    buttonLabel3=Label(eventConfig,text="Perception 3:")
    butonMode3=Entry(eventConfig)
    configureModes.append(butonMode3)
    buttonLabel4=Label(eventConfig,text="Perception 4:")
    butonMode4=Entry(eventConfig)
    configureModes.append(butonMode4)
    buttonLabel5=Label(eventConfig,text="Perception 5:")
    butonMode5=Entry(eventConfig)
    configureModes.append(butonMode5)
    buttonLabelEventID.pack()
    butonEventID.pack()
    buttonLabelThreshold.pack()
    butonThreshold.pack()
    buttonLabel1.pack()
    butonMode1.pack()
    buttonLabel2.pack()
    butonMode2.pack()
    buttonLabel3.pack()
    butonMode3.pack()
    buttonLabel4.pack()
    butonMode4.pack()
    buttonLabel5.pack()
    butonMode5.pack()
    button1=Button(eventConfig,
    text="Ok",command=lambda: configureEventOkPressed(eventConfig,butonEventID, butonThreshold,configureModes))
    button1.pack()
     
     
def configureEventOkPressed(eventConfig,butoneventID, butonThreshold,configureModes):
    global moods
    global eventID
    global threshold
    moods[:] = []
    eventID=butoneventID.get()
    threshold=int(butonThreshold.get())
    for cm in configureModes:
        moods.append(cm.get())



def sendPerception(userID,perception,location):
    global eventID
    global threshold
    global userCount
    url = 'http://192.248.15.232:3000/publishEventPerception'
    s=location.split(",")

    if userCount<=threshold:
        userCount+=1
    else:
        userCount=0
        
    params = urllib.urlencode({
      'eventID': eventID,
      'userID':userID+"_"+str(userCount),
      'perceptionValue':perception,
      'location':s[0],
      'lat': s[1],
      'lng': s[2],
    })
    response = urllib2.urlopen(url,params).read()
    

def getAveragePerception():
    global eventID
    url = 'http://192.248.15.232:3000/getHigestPerceptionOfEvent'
    params = urllib.urlencode({
      'eventID': eventID
    })
    response = urllib2.urlopen(url+'?'+params).read()
    return response
    
    

        

def addNewOkPressed(location,port,name,lat,longi):
    loc=location.get()+","+lat.get()+","+longi.get()
    prt=port.get()
    nm=name.get()
    addNewClientT(nm,prt,loc)

def addNewClientT(name,port,location):
    global count
    global ports
    global portLocations
    global portNames
    rowIDs[name] =t.insert("",count,text=name,values=(port,location,"online","test",datetime.datetime.now().time()))
    portNames[port]=name
    portLocations[port]=location
    count+=1
    ports.append(port)



class SummingThread(threading.Thread):
         
     def __init__(self,port):
         threading.Thread.__init__(self)
         self.port=port

     def run(self):
         arduino = serial.Serial(self.port, 9600)
         time.sleep(2)
         perception=""
         global moods
         global portNames
         global started
         global eventID
         global averagePerception
         temp1=eventID+";"+getAveragePerception()+";"
         for s in moods:
             temp1+=s+";"
         name=portNames[self.port]
         location=portLocations[self.port]

         intitRequest=""
         while True:
            c = arduino.read()
            if c != ";":
                intitRequest+=c
            else:
                break
                 
         print("Initilizing Request Recived")
         print("Sending Initilizing Message : "+temp1)
         arduino.write(temp1)

         intitCompleted=""
         while True:
             c = arduino.read()
             if c != ";":
                 intitCompleted+=c
             else:
                 break
                 
         print("Initilizing Completed Message Recived")
         
         temp2=""
         p="None"
         while started:            
             bChar = arduino.read()
             if bChar != ";" and bChar!='\n'and bChar!='\r':
                 temp2+=bChar            
             elif bChar == ";" :
                 sendPerception(name,temp2,location)
                 print("Sending Perception to API : "+name+","+temp2+","+location)
                 temp2=""
             if p !=averagePerception:
                 p=averagePerception
                 print("Sending Average Perception to Client : "+p)
                 arduino.write(p+";");
             


class SchedularThread(threading.Thread):
         
     def __init__(self):
         threading.Thread.__init__(self)

     def run(self):
         global averagePerception
         global started
         while started:
             time.sleep(60)
             p=getAveragePerception()
             if p!=averagePerception:
                 print("Average Perception Change Recived : "+averagePerception+" to "+p)
                 averagePerception=p
                            
             
def startClicked():
    global ports
    global threads
    global started
    started=True
    for item in ports:
        t1 = SummingThread(str(item))
        t1.start()
        threads.append(t1)
    t2=SchedularThread()
    t2.start()
     

def stopClicked():
    global started
    started=False

    

menubar = Menu(root)
filemenu = Menu(menubar, tearoff=0)
filemenu.add_command(label="New Client", command=addNewClient)
filemenu.add_command(label="Configure Event", command=configureEvent)
filemenu.add_command(label="Start All", command=startClicked)
filemenu.add_command(label="Stop All", command=stopClicked)
filemenu.add_separator()

filemenu.add_command(label="Exit", command=root.quit)
menubar.add_cascade(label="File", menu=filemenu)


root.config(menu=menubar)
root.title("Sith terminal admin")



# Apparently a common hack to get the window size. Temporarily hide the
# window to avoid update_idletasks() drawing the window in the wrong
# position.
root.withdraw()
root.update_idletasks()  # Update "requested size" from geometry manager

x = (root.winfo_screenwidth() - root.winfo_reqwidth()) / 2
y = (root.winfo_screenheight() - root.winfo_reqheight()) / 2
root.geometry("+%d+%d" % (x, y))

# This seems to draw the window frame immediately, so only call deiconify()
# after setting correct window position
root.deiconify()


w = Label(root, text="Connected clients")
w.pack()

t = ttk.Treeview(root, columns=('size', 'modified'))
t["columns"]=("second","third","fourth","fifth","sixth")
t.column("second",width=100)
t.column("third",width=125)
t.column("fourth",width=100)
t.column("fifth",width=100)
t.heading("second",text="Port")
t.heading("third",text="Location")
t.heading("fourth",text="Status")
t.heading("fifth",text="Last perception")
t.heading("sixth",text="Timestamp")




t.tag_configure("ttk")
t.pack()
root.mainloop()
