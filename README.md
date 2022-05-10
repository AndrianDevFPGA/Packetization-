# Packetization-
Packetization : In order to send the data between cores , the messages from the core should have the information of the destination (routing information from source to  destination). The packetizer module encode the messages from the core, and add head flits , body flits and tails flit for the messages.
this code is a sample of packetizer code , that can be used in the network interface for packetization.
