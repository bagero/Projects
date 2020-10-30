#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>



#define MAXmsg 141
#define MAXuser 3
#define MAXforum 10000

typedef int item;
#define key(A) (A)
#define less(A, B) (key(A) < key(B))


typedef struct dados 
/*sctruct que guarda em cada o utilizador e mensagem consoate a ordem 
  de   chegada e guarda tambem na primeira ocorrencia de 
                utilizador as vezes que add esse user */
{
	char msg[MAXmsg];
	int user, occ1;

}dados;

dados forum[MAXforum];

int c = 0;
int occ[MAXforum];

void add_msg(int user,char* msg)/*adiciona o user e a mensagem na struct*/
{
	int i=0;

	for (i = 0; i < c; i++)
	{
		if (user == forum[i].user)
		{
			forum[i].occ1++;     /*encontra a primeira occorencia do usar e incrementa na estrutura */

			break;
		}
		
	}
	/*caso contratrio adiciona normalmente*/
	forum[c].user=user;
	strcpy(forum[c].msg, msg);
	c++;
	
}

void list_msg()
/*devolve a lista de todas as mensagens por ordem de chegada*/
{
	int i=0;
	char new = '\n';
	printf("*TOTAL MESSAGES:%d\n", c );

	for (i = 0; i < c; i++)
	{
		if (strchr(forum[i].msg,new)!= NULL)
		/* strchr para verificar se o final e um \n*/		
		{
			printf("%d:%s",forum[i].user,forum[i].msg);
		}
		else
			printf("%d:%s\n",forum[i].user,forum[i].msg);
	}

	
}

void list_user(int user)
/*recebe um user e devolve a lista de mensagens do respetivo*/
{
	int i=0;

	printf("*MESSAGES FROM USER:%d\n", user);
	for (i = 0; i < c; i++)
		/*percorre a estrutura ate encontrar o user desejado e imprime as suas mensagens por ordem de chegada*/
		{
		if (((forum[i].user) == (user)) && ((forum[i].msg) != (NULL)))
			printf("%s",(forum[i].msg));	
		}
}

void lngst_msg()
/*devolve a msg mais longa ou as caso ocorra mais de uma vez*/

{

	int iMAX[c];
	int count_d =0;/*contador para guardar quantos indices com o mesmo comprimento*/
	int j=0;
	int d=0;
	int saved_d=0;/*variavel que guarda a posicao para comecar a imprimir*/
	int i=0;


	for (i = 0; i < c; i++)
	/*inicializa uma variavel para guardar os indices da estrutura*/
	{
		iMAX[i] = 0;
	}

	for (i = 0; i < c; i++)
	/* percorre na estrutura as mensagens */
	{
		

		if (strlen(forum[i].msg) == j)
		/*se for igual incrementa o iterador do imax 
		   guarda esse indice e aumenta o contador*/

		{
			
			
			d++;
			iMAX[d]= i;
			count_d++;		

		}

		if (strlen(forum[i].msg) > j)
		/*se for maior guarda o novo maximo substitui o indice mete 
		  o contador a 0 e guarda a posicao do indice onde comecar*/
		{
			
			j=strlen(forum[i].msg);
			iMAX[d]=i;
			count_d=0;
			saved_d=d;
			
		}
	}


	
	while (count_d >=0)
		/*acede aos ids e mensagens consoate a posicao guardada no imax*/
	{
		
		printf("*LONGEST SENTENCE:%d:%s\n", forum[iMAX[saved_d]].user, forum[iMAX[saved_d]].msg );
		saved_d++;
		count_d--;
	}
}

void mst_actv()
{   
	int MOSTatv[c];
	int count_d =0; /*contador que guarda os utilizadores igualmente frequentes*/
	int j=0;
	int d=0;
	int saved_d=0; /*variavel para guardar a posicao do primeiro maior*/
	int i=0;

	if (c == 1) {
		printf("*MOST ACTIVE USER:%d:%d\n", forum[0].user, j+1 );
		return;
	}

	for (i = 0; i < c; i++)
	{
		MOSTatv[i] = 0;
	}

	for (i = 0; i < c; i++)
	/*percore na estrutura as ocorrencias occ*/

	{
		
		if (forum[i].occ1 == j && forum[i].user != MOSTatv[d]) 
			/*se ocorrencias iguais e user for diferente do id que esta no mostatv incrementa 	
			o iterador do mostatv guarda o novo user e incrementa o contador*/
		{
			
			
			d++;
			MOSTatv[d]= forum[i].user;
			count_d++;
		
		}

		if (forum[i].occ1 > j)
			/*se for maior guarda o maximo de ocorrencias assim como o seu user no mostatv
			mete contador a 0 e guarda a posicao do novo maior*/
		{
			
			j=forum[i].occ1;
			MOSTatv[d]=forum[i].user;
			count_d=0;
			saved_d=d;
			
		}
	}


	int ordena (const void * a, const void * b)
	{
   		return ( *(int*)a - *(int*)b );

	}
	/*funcao para ordenar os numeros por ordem crescente*/
	qsort(MOSTatv, count_d+1, sizeof(int), ordena);


	while (count_d >=0)
	{
		
		printf("*MOST ACTIVE USER:%d:%d\n", MOSTatv[saved_d], j+1 );
		saved_d++;
		count_d--;
	}


}

void sorted_msgss()
{
	char temp[c][MAXmsg];/*array de arryas que guarda em cada indice a msg */
	int i=0;
	int j=0;
	char t[MAXmsg]; /*aux para guardar a msg a trocar*/
	int ti[c];/*aux para guardar o id a trocar*/
	int taux; /*aux para guardar o id a trocar*/

	if(c ==1)
		/*tratar do prolema do \n quando a estrutura so tem um user e uma msg*/
	{ 

 	printf("*SORTED MESSAGES:%d\n", c);
 	printf("%d:%s", forum[0].user, forum[0].msg );


	}
	else if (c  > 0)
	{
		
	
	
	for (i = 0; i <c ; i++)
	{
		
		strcpy(temp[i], forum[i].msg);/*copia as mensagens*/
		ti[i]=forum[i].user;/*guarda o id*/
		
	}



  	for (i = 0 ; i <  c-1 ; i++)
  	{
    	for (j = i+1 ; j < c ; j++)
    	{
      		if (strcmp(temp[i],temp[j])> 0)
      			/*se for maior copia para t a menor e para t1 o indice da menor
      			troca as msgs e as posicoes dos ids*/
      		{
        		strcpy(t, temp[i]);
        		taux= ti[i];
        		strcpy(temp[i], temp[j]);
        		ti[i]=ti[j];
        		strcpy(temp[j], t);
        		ti[j]=taux;
     		 }
     		 else if (strcmp(temp[i],temp[j]) == 0 && ti[j]<ti[i])
     		 	/*se for igual faz o mesmo mas apenas se o proximo user for maior*/
     		 {
     		 	strcpy(t, temp[i]);
        		taux= ti[i];
        		strcpy(temp[i], temp[j]);
        		ti[i]=ti[j];
        		strcpy(temp[j], t);
        		ti[j]=taux;
     		 }
   		}
  	}


  	printf("*SORTED MESSAGES:%d\n", c);
 
  	for ( i = 0 ; i < c ; i++ )
    	 printf("%d:%s",ti[i], temp[i]);

 
 
 
 	} 
 
}


void word_freq(char* word)
{
	int a = 0, i=0;
	char* token; /*variavel que guarda a mensagem por tokens*/
	int cont = 0;/*contador para as ocorrencias totais da palavra*/
	int flag = 0; /*auxiliar para somar as occurrencias existentes*/
	char esc[2] = " ";	/*limite do token*/

	for (a = 0; a < c; a++)
	{
		token = strtok(forum[a].msg, esc);

		while( token != NULL) 
		{
			if( strcmp(word, token) == 0)
			/*se o token for igual a palavra introduzida incrementa a sua ocorrencia
			 e altera a flag para mais tarde ir ao indice dessa palavra nas ocorrencias 
			  e somar o que ja la esta com as novas ocorrencias*/ 
			{
				occ[a]++;
				flag= 1;
			}
			else if ( strcmp(word, token) < 0)
			 {
				token[strlen(token) -1] = 0; /*se for diferente verifica se a diferenca esta no \n do final ou seja mete o a 0 e compara novamente*/
				if (strcmp(word, token) == 0) 
				{
					occ[a]++;
					flag = 1;	
				}
			}
			token = strtok(NULL, esc);
		}
	}
	if (flag==1)
	{
		for (i = 0; i < c; i++) {
			cont += occ[i];
		}
	}
	else {
		cont =0;
	}
	printf("*WORD %s:%d\n",word , cont );
}

int main() 
{
    char msg[MAXmsg];/*inicializa a variavel mensagem*/
  	int user;/* inicializa a variavel utilizador*/
	char cmd;
	char blank[2];/*variavel para guardar os espacos \0 \n */


	
	while (1) 
	{	
		cmd =getchar();
		
		switch (cmd)  
		{
			
			case 'A':		
				
				getchar();
				if (scanf("%d", &user)==1 && (scanf("%c", blank)==1 && fgets(msg, MAXmsg, stdin)))
					add_msg(user, msg);
					
			    
				break;


		    case 'L':

		    	getchar();
		    	list_msg();
		    	break;
		    	

		    case 'U':

		    	getchar();
		    	if (scanf("%d", &user)==1)
		    		list_user(user);
		    	break;

		    case 'O':

		    	getchar();
		    	lngst_msg();
		    	break;

		    case 'T':

		    	getchar();
		    	mst_actv();
		    	break;

		    case 'S':
		   		getchar();
		   		sorted_msgss();
		   		break;

		   	case 'C':
		   	getchar();
		   	if (scanf("%s", msg))
					word_freq(msg);
		   	break;


		   	case 'X':

		   		getchar();
		   		printf("%d\n", c);
		   		return(EXIT_SUCCESS);

		   	

		    }
	}
}
		   	


