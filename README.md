# up-ca-tp-integrador  
  
## Getting host ready  
Rename host with sudo hostnamectl set-hostname <name> and then  
Change the file in /etc/hosts  
  
## Setting policy  
iptables -P INPUT DROP  
iptables -P OUTPUT DROP  
iptables -P FORWARD DROP  
  
## allow loopback  
iptables -A INPUT -i lo -j ACCEPT    
iptables -A OUTPUT -o lo -j ACCEPT    
  
## allow firewall to access internet  
iptables -A INPUT -i eth0 -j ACCEPT  
iptables -A OUTPUT -o eth0 -j ACCEPT  
  
  
## do not allow cliente-03 access to java server  
iptables -A FORWARD -s 192.168.20.3 -d 192.168.10.3  -j DROP  
  
## Allowing cliente-03 to acces internet  
iptables -A FORWARD -s 192.168.20.3 -j ACCEPT  
iptables -A FORWARD -d 192.168.20.3 -j ACCEPT  
iptables -t nat -A POSTROUTING -j MASQUERADE  
  
  
## Allowing cliente-02 to access the firewall with ssh  
For this to work it was necessary to install ssh with sudo apt install ssh  
iptables -A INPUT -s 192.168.20.2 -p tcp -m tcp  --dport 22 -j ACCEPT  
iptables -A OUTPUT -s 192.168.20.1 -d 192.168.20.2 -p tcp -m tcp --sport 22 -j ACCEPT  
  
## Allow cliente-04 to access java server  
iptables -A FORWARD -s 192.168.20.4 -p tcp -m tcp  --dport 8080 -j ACCEPT  
iptables -A FORWARD -s 192.168.10.3 -d 192.168.20.4 -p tcp -m tcp  -j ACCEPT  
  
## Making changes to firewall on start  
iptables-save > rules.ipv4.conf  
Added iptables-restore < rules.ipv4.conf to etc/rc.local  
  
## Dhcp in dhcp-server  
Change files /etc/defaults/isc-dhcp-server  
and file etc/dhcp/dhcp/dhcpd.conf  
needed to restart dhcp service with   
/etc/init.d/isc-server restart  
  
## LVM y RAID  

Se implemento un sistema de RAID 1 con dos discos  
en el cliente-2 con el objetivo de darle al sistema mayor robustez  
Esto se puede ver con sudo mdadm -D /dev/md0

Se inplemento LVM con un solo volumen fisico (el cual  
estaba duplicado por el paso anterior) para constituir un  
unico volume group. Se crearon 2 logic volums:  
uno montado en / para contener contenido del usuario que va a ser  
variable como grabaciones de clases y otro  
en /var para guardar informacion de una base de datos   
para realizar data science  
Esto se puede ver con el comando lvdisplay  
Con esta configuracion obtenemos mas flexibilidad ya que  
podemos aumentar el size de los logical volumes sin ningun  
problema, algo en el sistema tradicional de particiones   
no es posible. Tenemos la capacidad de agregar otro disco duro y   
agregar su espacio  al volume group el cual luego lo podemos otorgar   
a un volumen logico.  Esto nos cubre ante la posibilidad de que la    
base de datos o la cantidad de grabaciones se salgan de control   
y ocupen todo el dispositivo.   

  
