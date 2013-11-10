from Tkinter import *
import ttk
import datetime
import serial
from threading import Thread
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


def addNewClient():
    addNew=Tk()
    addNew.geometry("250x175")
    addNew.title("Add new client")
    locationLabel= Label(addNew, text="Location: ")
    portLabel= Label(addNew, text="Port: ")
    nameLabel= Label(addNew, text="Name:")
    location = Entry(addNew)
    port = Entry(addNew)
    name = Entry(addNew)
    button1=Button(addNew,
      text="Add",command=lambda: addNewOkPressed(location,port,name))
    nameLabel.pack()
    name.pack()
    portLabel.pack()
    port.pack()
    locationLabel.pack()
    location.pack()
    button1.pack()

def configureEvent():
    eventConfig=Tk()
    eventConfig.title("Configure event")
    configureModes=list()
    buttonLabelEventID=Label(eventConfig,text="EventID:")
    butonEventID=Entry(eventConfig)
    buttonLabel1=Label(eventConfig,text="Button 1:")
    butonMode1=Entry(eventConfig)
    configureModes.append(butonMode1)
    buttonLabel2=Label(eventConfig,text="Button 2:")
    butonMode2=Entry(eventConfig)
    configureModes.append(butonMode2)
    buttonLabel3=Label(eventConfig,text="Button 3:")
    butonMode3=Entry(eventConfig)
    configureModes.append(butonMode3)
    buttonLabel4=Label(eventConfig,text="Button 4:")
    butonMode4=Entry(eventConfig)
    configureModes.append(butonMode4)
    buttonLabel5=Label(eventConfig,text="Button 5:")
    butonMode5=Entry(eventConfig)
    configureModes.append(butonMode5)
    buttonLabel6=Label(eventConfig,text="Button 6:")
    butonMode6=Entry(eventConfig)
    configureModes.append(butonMode6)
    buttonLabel7=Label(eventConfig,text="Button 7:")
    butonMode7=Entry(eventConfig)
    configureModes.append(butonMode7)
    buttonLabel8=Label(eventConfig,text="Button 8:")
    butonMode8=Entry(eventConfig)
    configureModes.append(butonMode8)
    buttonLabelEventID.pack()
    butonEventID.pack()
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
    buttonLabel6.pack()
    butonMode6.pack()
    buttonLabel7.pack()
    butonMode7.pack()
    buttonLabel8.pack()
    butonMode8.pack()
    button1=Button(eventConfig,
    text="Ok",command=lambda: configureEventOkPressed(eventConfig,butonEventID,configureModes))
    button1.pack()
     
     
def configureEventOkPressed(eventConfig,butoneventID,configureModes):
    global moods
    global eventID
    moods[:] = []
    eventID=butoneventID.get()
    for cm in configureModes:
        moods.append(cm.get())



def sendPercetion(userID,perception,location):
    global eventID   
    url = 'http://192.248.15.232:3000/publishEventPerception'
    params = urllib.urlencode({
      'eventID': eventID,
      'userID':userID,
      'perceptionVal':perception,
      'location':location
    })
    response = urllib2.urlopen(url, params).read()

        

def addNewOkPressed(location,port,name):
    loc=location.get()
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



class SummingThread(Thread):
         
     def __init__(self,port):
         Thread.__init__(self)
         self.port=port

     def run(self):
         arduino = serial.Serial(self.port, 9600)
         time.sleep(2)
         perception=""
         global moods
         global portNames
         global started
         name=portNames[self.port]
         location=portLocations[self.port]
         while started:
             bChar = arduino.read()
             if bChar == "1":
                 perception=moods[0]             
             elif bChar == "2":
                 perception=moods[1]
             elif bChar == "3":
                 perception=moods[2]
             elif bChar == "4":
                 perception=moods[3]
             elif bChar == "5":
                 perception=moods[4]
             elif bChar == "6":
                 perception=moods[5]
             elif bChar == "7":
                 perception=moods[6]
             elif bChar == "8":
                 perception=moods[7]
             sendPerception(name,perception,location)
             
def startClicked():
    global ports
    global threads
    global started
    started=True
    for item in ports:
        t1 = SummingThread(str(item))
        t1.start()
        threads.append(t1)

def stopClicked():
    global started
    started=False
    print temp
    




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

