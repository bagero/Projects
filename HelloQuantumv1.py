# Tiago Lopes - nr. 84770



size=(3,3,2) #tuplo auxiliar para verificar as posicoes do tabuleiro
estados=(0,1,-1) #tuplo auxiliar para verificar a validade dos estados de cada posicao

'''eh_tabuleiro - recebe um argumento verifica se t e um tuplo de tamanho 3 
                  com a ultima posicao de tamanho 2 depois a cada posicao de t 
                  se corresponde a um tuplo se o seu tamanho esta
                  de acordo com o tuplo size e finalmente verifica se os
                  estados das celulas sao validos'''

def eh_tabuleiro(t):
    s=0
    
    if (isinstance(t, tuple) and len(t)==3):
        for i in t:
            if isinstance(i, tuple) and len(i)==size[s]:
                for j in i:
                    if j not in estados:
                        return False
                
                s+=1
            else:
                return False
              
        return True
    
    return False




def tabuleiro_str(t):
    if (eh_tabuleiro(t)):
        draw=aux_desenho(t)   #lista com os carateres do tabuleiro 
        
        '''desenho da tabela '''
        
        tab0='+-------+\n'
        tab1='|...'+draw[2]+'...|\n'
        tab2='|..'+draw[1]+'.'+draw[5]+'..|\n'
        tab3='|.'+draw[0]+'.'+draw[4]+'.'+draw[7]+'.|\n'
        tab4='|..'+draw[3]+'.'+draw[6]+'..|\n'
        tab5='+-------+'  
        
        return tab0+tab1+tab2+tab3+tab4+tab5
    
    else:
        raise ValueError('tabuleiro_str: argumento invalido')
    
'''se os tabuleiros forem validos retorna a validade da igualdade t1=t2'''

def tabuleiros_iguais(t1,t2):
    if (eh_tabuleiro(t1) and eh_tabuleiro(t2)):
        return(tabuleiro_str(t1)==tabuleiro_str(t2))
    
    else:
        raise ValueError('tabuleiros_iguais: um dos argumentos nao e tabuleiro')
    


    
def porta_x(t,d):
    esquerda=(3,4,5) #vetor auxiliar com os indices a mudar a esquerda
    direita=(1,4,6) #vetor auxiliar com os indices a mudar a direita
    if(eh_tabuleiro(t) and (d=='D' or d=='E')):
        draw=aux_desenho(t)
        
        if d=='E':
            for i in esquerda:        #troca os 0 por 1 na lista com os carateres a representar no tabuleiro
                if draw[i]=='0':
                    draw[i]='1'
                
                elif draw[i]=='1':    #troca os 1 por 0
                    draw[i]='0'
        
        elif d=='D':
            for i in direita:
                if draw[i]=='0':
                    draw[i]='1'
                    
                elif draw[i]=='1':
                    draw[i]='0'
        
        
        
        return aux_portas(draw)  #funcao auxiliar que converte a lista draw num tabuleiro

        
    else:
        raise ValueError('porta_x: um dos argumentos e invalido')
        
 
'''porta_z - comportamento identico a porta_x apenas muda os indices a alterar'''      
def porta_z(t,d):
    esquerda=(0,1,2)
    direita=(2,5,7)
    if(eh_tabuleiro(t) and (d=='D' or d=='E')):
        draw=aux_desenho(t)
        
        if d=='E':
            for i in esquerda:
                if draw[i]=='0':
                    draw[i]='1'
                
                elif draw[i]=='1':
                    draw[i]='0'
        
        elif d=='D':
            for i in direita:
                if draw[i]=='0':
                    draw[i]='1'
                    
                elif draw[i]=='1':
                    draw[i]='0'
        
        
        
        return aux_portas(draw)

        
    else:
        raise ValueError('porta_z: um dos argumentos e invalido')    
        
'''porta_h - utilizando a lista com os carateres a representar no tabuleiro
            troca os de posicao na lista '''

def porta_h(t,d):
    if(eh_tabuleiro(t) and (d=='D' or d=='E')):
        draw=aux_desenho(t)
        esquerda=(0,1,2) #vetor auxiliar com as posicoes a alterar a esquerda
        direita=(1,4,6)  #valores a alterar a direita
        if d=='E':
            for i in esquerda:
                if i==0:
                    aux=draw[i]        #guarda o valor antigo
                    draw[i]=draw[3]    #troca o
                    draw[3]=aux        #atualiza a outra posicao
                    
                elif i==1:
                    aux=draw[i]
                    draw[i]=draw[4]
                    draw[4]=aux
                    
                else:
                    aux=draw[i]
                    draw[i]=draw[5]
                    draw[5]=aux
                    
                
            return aux_portas(draw)
        
        
        elif d=='D':
            for i in direita:
                if i==1:
                    aux=draw[i]
                    draw[i]=draw[2]
                    draw[2]=aux
                    
                elif i==4:
                    aux=draw[i]
                    draw[i]=draw[5]
                    draw[5]=aux
                    
                else:
                    aux=draw[i]
                    draw[i]=draw[7]
                    draw[7]=aux
                    
                
            return aux_portas(draw)            
        
        
    else:
        raise ValueError('porta_h: um dos argumentos e invalido')          
        
        
        
        
        
        
        
'''aux_portas - converte a lista de carateres fornecida pela funcao 
                 aux_desenho e transforma a num tabuleiro'''      

def aux_portas(t):
    for i in range(len(t)):
        if t[i] == 'x': 
            t[i]=-1
            
        elif t[i]=='0':
            t[i]=0
            
        else:
            t[i]=1
        
    return ((int(t[0]),int(t[1]),int(t[2])),(int(t[3]),int(t[4]),int(t[5])),(int(t[6]),int(t[7])))    
    
        
  
  
      
    
    
'''aux_desenho - copia o tabuleiro para uma lista com todos os carateres
                 do tabuleiro seguidos substituindo os valores -1 por x'''

            
def aux_desenho(t):
    aux=[]
    for i in t:
        for j in i:
            if j ==-1:
                aux+=['x']
            else:
                aux+=str(j)
    return aux  
                  

def cria_celula(valor):
    celula=''
    if (isinstance(valor, int) and valor>=-1 and valor<=1):
        if valor==0:
            celula='inativo'
        
        if valor==1:
            celula='ativo'
        
        elif valor==-1:
            celula='incerto'
            
        return celula
    
    else:
        raise ValueError('cria_celula: argumento invalido')
    
def obter_valor(celula):
    
    if celula == 'inativo':
        return 0
    
    if celula=='ativo':
        return 1
    
    elif celula =='incerto':
        return -1
    

def inverte_estado(celula):
    
    if celula=='ativo':
        return 'inativo'
    
    if celula=='inativo':
        return 'ativo'
    
    else:
        return 'incerto'
    
def eh_celula(arg):
    if isinstance(arg,str) and (arg =='inativo' or arg=='ativo' or arg=='incerto'):
        return True

    else:
        return False
    
def celulas_iguais(c1,c2):
    return c1==c2


def celula_para_str(celula):
    c=obter_valor(celula)
    if c == -1:
        return 'x'
    
    else:
        return str(c)
    

def cria_coordenada(l,c):
    if isinstance(l,int) and l>=0 and l<=2:
        if isinstance(c,int) and c>=0 and c<=2:
            return (l,c)
        
    
    raise ValueError('cria_coordenada: argumentos invalidos')

def coordenada_linha(pos):
    return pos[0]

def coordenada_coluna(pos):
    return pos[1]


def eh_coordenada(arg):
    
    if isinstance(arg,tuple) and isinstance(arg[0],int) and isinstance(arg[1],int):
        if arg[1] >=0 and arg[1]<=2 and arg[0]>=0 and arg[0] <= 2:            
            return True
        
        else:
            return False
    else:
        return False
    
def coordenadas_iguais(c1,c2):
    return c1==c2


def coordenada_para_str(c):
    return str(c)



def tabuleiro_inicial():
    return ((-1,-1,-1),(1,1,-1),(1,-1))

def str_para_tabuleiro(s):
    estados=(0,1,-1)
    i=0
    aux=[]
    for i in range(len(s)):
        if s[i] not in estados:
            i+=1
        
        aux+=[int(s[i])]
        
    tabuleiro=((aux[0],aux[1],aux[2]),(aux[3],aux[4],aux[5]),(aux[6],aux[7]))
    if eh_tabuleiro(tabuleiro):
        return tabuleiro
    
    else:
        raise ValueError('str_para_tabuleiro: argumentos invalidos')
    
   