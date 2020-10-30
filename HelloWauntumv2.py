#Tiago Lopes nr 84770
size=(3,3,2)
estados=(0,1,-1)

'''Seccao celula '''

'''cria celula recebe um inteiro e devolve a 
               celula correspondente ao valor introduzido'''
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
        raise ValueError('cria_celula: argumento invalido.')
    
'''obter valor recebe uma celula e devolve o valor correspondente'''
def obter_valor(celula):
    
    if celula == 'inativo':
        return 0
    
    if celula=='ativo':
        return 1
    
    elif celula =='incerto':
        return -1
    
'''inverte_estado-recebe uma celula e devolve inativo se a celula estiver ativa
                  ativo se a celula estiver inativa e incerto se a celula 
                  estiver incerta''' 

def inverte_estado(celula):
    cel=''
    if eh_celula(celula):
        if celula=='ativo':
            cel=cria_celula(0)
            return cel       
            
        if celula =='inativo':
            cel=cria_celula(1)
            return cel
        
        if celula=='incerto':
            cel=cria_celula(-1)
            return cel
        
        
'''eh_celula-recebe um argumento devolve true se o argumento 
              for ativo inativo ou incerto caso contrario devolve false'''   
def eh_celula(arg):
    if isinstance(arg,str) and (arg =='inativo' or arg=='ativo' or arg=='incerto'):
        return True
        
    else:
        return False
    
'''celulas_iguais-se as celulas forem do tipo celula escolhido e iguais 
                  devolve True e false caso contrario'''   
def celulas_iguais(c1,c2):
    if eh_celula(c1) and eh_celula(c2):
        return c1==c2
        
    return False

'''celula_para_str-recebe uma celula obtem o seu valor 
                   e retorna a string correspondente'''

def celula_para_str(celula):
    if eh_celula(celula):        
        c=obter_valor(celula)
        if c == -1:
            return 'x'
        
        else:
            return str(c)
        
'''Seccao coordenada'''    

'''cria_coordenada-verifica se os argumentos estao entre 0 e 2 '''
def cria_coordenada(l,c):
    if isinstance(l,int) and l>=0 and l<=2:
        if isinstance(c,int) and c>=0 and c<=2:
            return (l,c)
        
    
    raise ValueError('cria_coordenada: argumentos invalidos.')

'''coordenada_linha-devolve a linha'''
def coordenada_linha(pos):
    return pos[0]

'''coordenada_coluna-devolve a coluna'''
def coordenada_coluna(pos):
    return pos[1]

'''eh_coordenada-se o argumento for um tuplo com os dois indices entre 0 e 2 
                devolve True caso contrario devolve False'''
def eh_coordenada(arg):
    
    if isinstance(arg,tuple) and len(arg)==2:
        if isinstance(arg[0],int) and isinstance(arg[1],int):
        
            if arg[0] >=0 and arg[0]<=2 and arg[1]>=0 and arg[1] <= 2:
                return True
        else:
            return False
        
    else:
        return False
    
'''coordenadas_iguais-devolve True se as coordenadas forem iguais'''
def coordenadas_iguais(c1,c2):
    if eh_coordenada(c1) and eh_coordenada(c2):
        return c1==c2
    
    else:
        return False
'''coordenada_para_str-devolve a string correspondente a coordenada'''    
def coordenada_para_str(c):
    return str(c)

'''Seccao Tabuleiro'''
'''tabuleiro_inicial-devolve o tabuleiro default'''
def tabuleiro_inicial():
    return ((-1,-1,-1),(0,0,-1),(0,-1))

'''str_para_tabuleiro-recebe uma string e devolve o tabuleiro correspondente'''
def str_para_tabuleiro(s):
    estados=('0','1')
    nana=('[',']')
    i=0
    aux=[] # vetor auxiliar para guardar os valores a converter em tabuleiro
    
    if isinstance(s, str):
        for i in range(len(s)):
            if s[i] in estados:
                if s[i-1]=='-':   #se encontrar o 1 e tiver um menos antes
                    aux+=[-1]     #coloca o menos 1 no vetor auxiliar
                
                else:
                    aux+=[int(s[i])]  #caso contrario adiciona normalmente
                    
            elif s[i] in nana: 
            #se encontrar elementos que nao pertencam ao tabuleiro
            #levanta caso de erro             
                raise ValueError('str_para_tabuleiro: argumento invalido.') 
                   

        
        if len(aux)!=8: 
        #se nao conseguiu copiar os 8 valores  da erro e nao cria o tabuleiro
            raise ValueError('str_para_tabuleiro: argumento invalido.')
        
        
        tabuleiro=((aux[0],aux[1],aux[2]),(aux[3],aux[4],aux[5]),(aux[6],aux[7]))
        #caso contrario cria tabuelrio
        
        if eh_tabuleiro(tabuleiro): 
            #verifica a sua validade e devolve o caso seja verdadeiro
            return tabuleiro
    
    else: # caso contrario da erro
        raise ValueError('str_para_tabuleiro: argumento invalido.')
    
def tabuleiro_dimensao(t):
    return 3

'''tabuleiro_celula-recebe um tabuleiro e uma coordenada e 
                 devolve a celula da respetiva coordenada'''
def tabuleiro_celula(t, coor):
    if eh_tabuleiro(t) and eh_coordenada(coor):
        if coor[0]==2:
            if coor[1]==1: 
            #se for pedida a posicao 2 1 faz a conversao para a posicao no tuplo
                return cria_celula(t[2][0])
            elif coor[1]==2: 
            #se for pedida a posicao 2 2 faz a conversao para a posicao no tuplo
                return cria_celula(t[2][1])
            
        elif coor!=(2,0): 
            # como a posicao 2 0 nao existe no tabuleiro de jogo
            #devolve as celulas correspondentes a outras coordenadas
            return cria_celula(t[coor[0]][coor[1]]) 

'''aux_conversao-recebe um tabuleiro e transforma o num 
                 tabuleiro lista de listas em vez de tuplos'''

def aux_conversao(t):
    aux=[]
    for i in t:
        aux+=[list(i)]
    
    return aux



'''aux_inversao-recebe uma tabuleiro em listas e converte o em tuplo de tuplos'''
def aux_inversao(t):
    return (tuple(t[0]),tuple(t[1]), tuple(t[2]))


        
'''tabuleiro_substitui_celula recebe um tabuleiro uma celula e uma coordenada 
              substitui no tabuleiro t na coordenada coor a nova celula cel'''    
def tabuleiro_substitui_celula(t,cel,coor):
    
    if eh_tabuleiro(t) and eh_coordenada(coor) and eh_celula(cel) and coor!=(2,0):
        tabuleiro=aux_conversao(t) # converte o tabuleiro para lista de listas
        celula=obter_valor(cel) #obtem o valor a inserir na posicao
        
        #conversoes no caso de ser as posicoes 2 1 e 2 2 para posicoes reais
        if coor[0]==2:
            if coor[1]==1:
                tabuleiro[coor[0]][0]=celula
            
            if coor[1]==2:
                tabuleiro[coor[0]][1]=celula
                
        # caso contrario substitui normalmente         
        else:
            tabuleiro[coor[0]][coor[1]]=celula
        
        tabuleiro=aux_inversao(tabuleiro)#converte o tabuleiro para tuplo de tuplos
        return tabuleiro#devolve o novo tabuleiro
    
    else:
        raise ValueError('tabuleiro_substitui_celula: argumentos invalidos.')  
    
def tabuleiro_inverte_estado(t,coor):
    if eh_tabuleiro(t) and eh_coordenada(coor) and coor!=(2,0):
        tabuleiro=aux_conversao(t)#converte para lista de listas
        pos=[coor[0],coor[1]]
        
        if coor[0]==2:
           
            if coor[1]==1: #se pedir a coordenada 2 1 guarda a celula em 2 0
                celula=tabuleiro[coor[0]][0]
                pos[1]=0 # atualiza a posicao
            
            elif coor[1]==2:#se pedir a coordenada 2 2 guarda a celula em 2 1
                celula=tabuleiro[coor[0]][1]
                pos[1]=1#atualiza a posicao
                
        
        #se nao for um dos casos especiais guarda a celula presente na coordenada
        else:
            celula=tabuleiro[pos[0]][pos[1]]
        
        celula=cria_celula(celula) #cria a celula
        celula=inverte_estado(celula) # inverte a
        celula=obter_valor(celula) #obtem o valor a substituir no tabuleiro
        tabuleiro[pos[0]][pos[1]]=celula #substitui no tabuleiro
        
        return aux_inversao(tabuleiro) 
        # devolve o novo tabuleiro em tuplo de tuplos
    
    else:
        raise ValueError('tabuleiro_inverte_estado: argumentos invalidos.')
    
    
'''eh_tabuleiro-devolve verdadeiro se o argumento for um tuplo com 3 tuplos 
                sendo o ultimo tuplo com len==2 e os restantes com len==3'''

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

'''tabuleiros_iguais-devolve true se ambos forem tabuleiros e se forem iguais'''
def tabuleiros_iguais(t1,t2):
    if eh_tabuleiro(t1) and eh_tabuleiro(t2):
        return t1==t2
    else:
        return False
    
'''tabuleiro_para_str-recebe um tabuleiro e converte o em string'''
def tabuleiro_para_str(t):
    t=aux_conversao(t)
    i=0
    j=0
    for i in range(len(t)):
        for j in range(len(t[i])):
            if t[i][j]==-1:
                t[i][j]='x'
            
    tab0='+-------+\n'
    tab1='|...'+str(t[0][2])+'...|\n'
    tab2='|..'+str(t[0][1])+'.'+str(t[1][2])+'..|\n'
    tab3='|.'+str(t[0][0])+'.'+str(t[1][1])+'.'+str(t[2][1])+'.|\n'
    tab4='|..'+str(t[1][0])+'.'+str(t[2][0])+'..|\n'
    tab5='+-------+'  
    
    return tab0+tab1+tab2+tab3+tab4+tab5    


'''porta_x-recebe um tabuleiro e uma orientacao e inverte o estado nas posicoes 
           respetivas'''
def porta_x(tab,d):
    if(eh_tabuleiro(tab) and (d=='D' or d=='E')):
        if d=='E':
            tab=tabuleiro_inverte_estado(tab,(1,0))
            tab=tabuleiro_inverte_estado(tab,(1,1))
            tab=tabuleiro_inverte_estado(tab,(1,2))
            
        if d=='D':
            tab=tabuleiro_inverte_estado(tab,(2,1))
            tab=tabuleiro_inverte_estado(tab,(1,1))
            tab=tabuleiro_inverte_estado(tab,(0,1))            
                
        
        
        return tab
    
    else:
        raise ValueError('porta_x: argumentos invalidos.')
    

'''porta_z-comportamento semelhante a porta x apenas aplicada as posicoes 
           a celula superiores'''
def porta_z(tab,d):
    if(eh_tabuleiro(tab) and (d=='D' or d=='E')):
        if d=='E':
            tab=tabuleiro_inverte_estado(tab,(0,0))
            tab=tabuleiro_inverte_estado(tab,(0,1))
            tab=tabuleiro_inverte_estado(tab,(0,2))
            
        if d=='D':
            tab=tabuleiro_inverte_estado(tab,(2,2))
            tab=tabuleiro_inverte_estado(tab,(1,2))
            tab=tabuleiro_inverte_estado(tab,(0,2))
                
        
        
        return tab
    
    else:
        raise ValueError('porta_z: argumentos invalidos.')
    
'''porta_h troca a linha 0 com a linha 1 se for a 
           esquerda e a coluna 1 2 se for a direita'''   

def porta_h(tab,d):
    t=aux_conversao(tab)
    aux=[]
    if(eh_tabuleiro(tab) and (d=='D' or d=='E')):
        if d=='E':
            aux+=[t[0][0]]+[t[0][1]]+[t[0][2]]
            t[0][0]=t[1][0]
            t[0][1]=t[1][1]
            t[0][2]=t[1][2]
            t[1][0]=aux[0]
            t[1][1]=aux[1]
            t[1][2]=aux[2]  
            
        if d=='D':
            aux+=[t[2][0]]+[t[1][1]]+[t[0][1]]
            t[2][0]=t[2][1]
            t[1][1]=t[1][2]
            t[0][1]=t[0][2]
            t[2][1]=aux[0]
            t[1][2]=aux[1]
            t[0][2]=aux[2]           
        
        return aux_inversao(t)
        
        
    else:
        raise ValueError('porta_h: argumentos invalidos.')


def hello_quantum(arg):
    moves=int(arg[-1:])#guarda o numero de jogadas maximas a realizar
    res=str_para_tabuleiro(arg[:-2])#guarda o tabuleiro final
    tabuleiro=tabuleiro_inicial()#guarda o tabueliro de jogo
    count=0 # contador para nao ultrapassar as jogadas maximas
    print('Bem-vindo ao Hello Quantum!')
    print('O seu objetivo e chegar ao tabuleiro:')
    print(tabuleiro_para_str(res))
    print('Comecando com o tabuleiro que se segue:')
    print(tabuleiro_para_str(tabuleiro_inicial()))
    
    
    
    
    while(count<moves):
        porta=str(input('Escolha uma porta para aplicar (X, Z ou H): '))
        #pede a porta a aplicar
        direcao=str(input('Escolha um qubit para analisar (E ou D): '))
        #pede a direcao
        if porta=='X':
            tabuleiro=porta_x(tabuleiro,direcao)
            #substitui o tabuleiro pelo resultante de aplicar a porta X
            print(tabuleiro_para_str(tabuleiro))#desenha o
            count+=1 #incrementa as jogadas
            
        if porta=='Z':
            tabuleiro=porta_z(tabuleiro,direcao)
            #substitui o tabuleiro pelo resultante de aplicar a porta Z
            print(tabuleiro_para_str(tabuleiro)) 
            count+=1
            
        if porta=='H':
            tabuleiro=porta_h(tabuleiro,direcao)
            #substitui o tabuleiro pelo resultante de aplicar a porta H
            print(tabuleiro_para_str(tabuleiro)) 
            count+=1
            
        elif tabuleiros_iguais(res,tabuleiro): 
            #se o tabuleiro de jogo for igual ao tabuleiro objetivo
            print('Parabens, conseguiu converter o tabuleiro em',count,'jogadas!')            
            return True #devolve True
    
    #se ja ultrapassou as jogadas e nao chegou ao tabuleiro objetivo retorna False
    return False