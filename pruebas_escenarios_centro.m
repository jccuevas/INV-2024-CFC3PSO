load variables_menos_x_y_ebx_eby.mat

EBx=50
EBy=50

Eminima=0.01
n=100

load escenario.mat

fis_fnd = readfis('kb_wsn_tras_fnd_centro.fis');
fis_hnd= readfis('kb_wsn_tras_fnd_hnd_centro.fis');
fis_lnd= readfis('kb_wsn_tras_fnd_hnd_lnd_centro.fis');


for k=1:15,

    x=X(k,:);
    y=Y(k,:);

[FND(k) HND(k) LND(k)] = optimized(x,y,x_max,y_max,n,stop,p,fis_fnd,fis_hnd,fis_lnd,EBx,EBy,Eo,ETX,ERX,Efs,Eamp,EDA,packetSize,controlPacketSize,Eminima)

end