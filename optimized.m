% Fichero para optimizar los pesos de la base de conocimiento 
%ya se tiene en fis_fnd la baseoptimizada hasta el FND
%se tiene en fis_Hnd la base optimizada hsta el HND
% Método centralizado

%Licencia CC 3.0
%Citar

%Muñoz-Exposito, J. E., Yuste-Delgado, A. J., Triviño-Cabrera, A., & Cuevas-Martinez, J. C. 
%(2024). 
%Optimizing Rule Weights to Improve FRBS Clustering in Wireless Sensor Networks. Sensors (Basel, Switzerland), 24(17), 5548.
%DOI: https://doi.org/10.3390/s24175548


function [FND, HND, LND] = optimized(x,y,x_max,y_max,n,stop,leach,fis_fnd,fis_hnd,fis_lnd,EBx,EBy,Eo,ETX,ERX,Efs,Eamp,EDA,packetSize,controlPacketSize,Eminima)


%x: vector con las abcisas en las que se encuentran los sensores
%y: vector con las ordenadas en las que se encuentran los sensores

%x_max: dimensión máxima x
%y_max: dimensión máxima y

%n:  Numer of nodes in the experiment
%stop: número de muertes para llegar al final en % sobre n
%leach: variable p del método de LEACH

%EBx: coordenada x de la estación base
%EBy: coordenada y de la estación base

%Eminima: energía mínima antes de que un nodo se considere muerto


%The seed for random function is stablish
seed=2;

%RandStream.setDefaultStream(RandStream('mt19937ar','seed',seed));
RandStream.setGlobalStream(RandStream('mt19937ar','seed',seed));


%Computation of do
do=sqrt(Efs/Eamp);



MAXCAM=sqrt(x_max^2+y_max^2);


nodos_vivos=1:n; %(alive nodes)
energias_nodos=ones(1,n)*Eo;


% para posteriores implementaciones en las que haya más incertidumbre 
cx =[x EBx];
cy =[y EBy];

%Primero calculo todas las distancias entre los nodos y los introduzco en la matriz distancia
% con esto luego me sale más fácil encontrar el CH al que se conecta

%quito la EB
distancia = sqrt((cx(1:n) - cx(1:n)').^2 + (cy(1:n)-cy(1:n)').^2);


%distancias a la EB
d_a_EB = sqrt ( (cx(1:n) -cx(n+1)).^2 + (cy(1:n)- cy(n+1)).^2);

%Ahora normalizamos las distancias
	d_a_EB_norm= d_a_EB /max(d_a_EB);

%Envío del mensaje inicial de la estación base
%Sería un mensaje de control

energias_nodos= energias_nodos - disminuir_energia_recibir_mensaje(controlPacketSize,ERX);

	%los nodos mandan un mensaje a la máxima distancia incluida la MAXCAM para que la EB y todos los nodos lean
%esto será muy negativo para algunos nodos que estén más cerca de la EB
%sobre todo cuanto la EB está fuera del rectángulo
 energias_nodos= energias_nodos - disminuir_energia_envio_mensaje(max(MAXCAM,d_a_EB),controlPacketSize,do,ETX,Eamp,Efs);

%además cada nodo deber recibir n-1 mensajes
energias_nodos= energias_nodos - (n-1)*disminuir_energia_recibir_mensaje(controlPacketSize,ERX);

%ahora vamos a buscar el número de vecinos o degree
% se mide en función de la distancia d0
sensado = do;

%para cada nodo se buscan las distancias menores a sensado

vecinos=zeros(n,1);
for i=1:length(nodos_vivos)
 vecinos(i)= sum(distancia(i,:) < sensado )- 1;
end

%normalizamos

vecinos = vecinos/max(vecinos);


%ahora nos queda la centralidad

%ahora hay que calcular la centralidad de 0 a 1
%se define como la distancia al centroide del cluster que es la salida del
%kmeans

%creamos tantos cluster como el óptimo de leach
%aunque luego no  elegimos un CH para cada cluster...
%Esto habrá que repetirlo,a medida, que se vayan muriendo los nodos
clusteres_actuales = fix(n*leach)+1;

[idx,centroides] = kmeans([cx;cy]',clusteres_actuales);
 centralidad=[];

 for i=1:clusteres_actuales
  nodos = (idx == i);
  centralidad = [centralidad (cx(nodos)- centroides(i,1)).^2 + (cy(nodos) - centroides(i,2)).^2];
 end
 
 %cuánto más pequeño es la centralidad mejor. Así que hay que invertir.
 centralidad = 1- centralidad/ max(centralidad);
 

dead=0;

FND=-1;
HND=-1;
LND=-1;


%kb = readfis('kb_wsn.fis');

kb =fis_fnd;
%cuantas más rotacion sería peor tendría que cambiar la rotación 

rotacion = ones(1,n);
total_ch=0;%pongo uno para evitar la división por cero. TAmpoco influye mucho

for r=0:rmax

    if mod(r,500)==0
		disp([r length(nodos_vivos) dead FND HND LND])
	end

	%primero eliminamos los nodos sin energía
    i=1;
	
    while (i<=length(nodos_vivos))
    %for i=1:length(nodos_vivos) Nodos vivos los voy eliminados en el bucle
    %por lo que no puede ser un for
        	
		
		if (energias_nodos(nodos_vivos(i))<=Eminima)
            
                    %nombre=sprintf('FND_map_set%d_%.3d.mat',set,nmap);

            %energias_nodos(nodos_vivos(i))
			%eliminar el nodo vivo de la lista
			if (i==1)
				nodos_vivos=nodos_vivos(2:length(nodos_vivos));
                i=i-1;
			elseif i==length(nodos_vivos)
				nodos_vivos=nodos_vivos(1:length(nodos_vivos)-1);
                i=i-1;
			else
				nodos_vivos=[nodos_vivos(1:i-1) nodos_vivos(i+1:length(nodos_vivos))];
                i=i-1;
			end
			
			
			dead=dead+1;
			if (dead==1)
				%if(flag_first_dead==0)
					FND=r;
                    
                    disp('Cambio de base');
                    kb =fis_hnd;
                    

				%    flag_first_dead=1;
				%end
			end
			if (dead==fix(n*0.5))
				%if(flag_half_dead==0)
				HND=r;
                disp('Cambio de base');

				kb=fis_lnd;
				%flag_half_dead=1;
				%end
			end
	
        end
		
        i=i+1;
        
    end
    
	%comprobar que no se ha acabado
	if(n-dead<=n*stop)
		LND=r ;
	break;
    end
     
    %comprobar que no haya que cambiar la centralidad por muerte de nodos
    if clusteres_actuales > fix(length(nodos_vivos)*leach)+1
        clusteres_actuales  = fix(length(nodos_vivos)*leach)+1;
        
         [idx,centroides] = kmeans([cx(nodos_vivos);cy(nodos_vivos)]',clusteres_actuales);
         %lo pongo negativo para que el fuzzy nos de un error si algo falla
         centralidad=-30000*ones(1,n);

         for i=1:clusteres_actuales
            nodos = (idx == i);
            centralidad(nodos_vivos(nodos)) =  (cx(nodos_vivos(nodos))- centroides(i,1)).^2 + (cy(nodos_vivos(nodos)) - centroides(i,2)).^2;
         end
 
         %cuánto más pequeño es la centralidad mejor. Así que hay que invertir.
           centralidad = 1- centralidad/ max(centralidad);

    end
    
			 
        %ahora calculamos el difuso con las variables para obtener los CH
        
        %DEB;centralidad;vecinos;energia residual;rotacion_ch
        
        %rotacion tenemos un problema así que lo vamos a normalizar sobre
        %elmáximo y no sobre el total ch
        
        chance =evalfis(kb,[d_a_EB_norm(nodos_vivos); centralidad(nodos_vivos); energias_nodos(nodos_vivos)/Eo; vecinos(nodos_vivos)'; 1-rotacion(nodos_vivos)/max(rotacion(nodos_vivos))]);
     
        %ahora elegimos los mejores CH
        [chance, indices_ch]= sort(chance,'descend');
        
        indices_ch =indices_ch(1:clusteres_actuales);
        
        %actualizamos la rotacion y el total de CH
        
        total_ch = total_ch + clusteres_actuales;
        rotacion(nodos_vivos(indices_ch)) =rotacion(nodos_vivos(indices_ch)) + 1;
        
        %La EB manda un mensaje a todos los nodos indicando quienes son los
        %CHs
        energias_nodos (nodos_vivos) = energias_nodos(nodos_vivos) - disminuir_energia_recibir_mensaje(controlPacketSize,ERX);
        
        %ahora los nodos se adscriben al CH más cercano
        
        for i=1:length(nodos_vivos)
            
           %primero vemos que no es ch
           ver_si_ch = nodos_vivos(i) == nodos_vivos(indices_ch);
           
           if sum(ver_si_ch) == 0
           
            %vemos las distancias entre el nodo y los clusteres
            d = distancia(nodos_vivos(i),nodos_vivos(indices_ch));
           
            [valor, ch_elegido]= min(d);
            ch_elegido = nodos_vivos(indices_ch(ch_elegido)); %ahora estará el índice en absoluto
            
            
            %ahora enviamos el dato al cluster
              energias_nodos(nodos_vivos(i)) = energias_nodos(nodos_vivos(i))- disminuir_energia_envio_mensaje(valor,packetSize,do,ETX,Eamp,Efs);
            %ahora el cluster recibe el dato y lo agrega
            energias_nodos(ch_elegido) = energias_nodos(ch_elegido)- disminuir_energia_recibir_mensaje(packetSize,ERX);
            energias_nodos(ch_elegido) = energias_nodos(ch_elegido) - disminuir_energia_agregacion(packetSize,EDA);
           end
           
            
        end
            
        
        
	
	%%AHORA los clusteres envían los datos a la EB
    
	for i=1:length(indices_ch)
    	energias_nodos(nodos_vivos(indices_ch(i)))=  energias_nodos(nodos_vivos(indices_ch(i))) - disminuir_energia_envio_mensaje(d_a_EB(nodos_vivos(indices_ch(i))),packetSize,do,ETX,Eamp,Efs);	
	end
		
	
end %r
	
cprintf('_red',['- FND=', num2str(FND),' HND=', num2str(HND),' LND=', num2str(LND) ]);
disp(' ');

end %function




function perdidas= disminuir_energia_envio_mensaje(distancia,longitud,do,ETX,Emp,Efs)


 if (distancia>do)
    perdidas=( ETX*(longitud) + Emp*longitud*(distancia.^4));
 else
    perdidas=( ETX*(longitud) + Efs*longitud*(distancia.^2)); 
 end

 end


function perdidas= disminuir_energia_recibir_mensaje(longitud,ERX)

 %%DEFINIR ETX ...
 
 %distancia = sqrt((xa-xb)^2+(ya-yb)^2);

 perdidas= ERX*longitud;
end

function perdidas= disminuir_energia_agregacion(longitud,EDA)

perdidas= longitud * EDA;

end


