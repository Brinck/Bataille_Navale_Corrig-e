program Bataille_Navale (input,output);

uses crt;

const
        //Bateaux
        NBBATEAU=2;//Nombre max de bateaux
        MAXCASE=5;//Taille max d'un bateau

        //Lignes
        MINL=1;
        MAXL=50;

        //Colonnes
        MINC=1;
        MAXC=50;

//TYPES
//Cases
Type
        Cases=record
                ligne:integer;
                colonne:integer;
        end;

//Bateau
Type
        Bateau=record
                nCase:array[1..MAXCASE] of Cases;
        end;

//Flotte
Type
        Flotte=record
                nBateau:array[1..NBBATEAU] of Bateau;
        end;

//Etats
Type
        positionBateau=(enLigne,enColonne,enDiag);
        etatBateau=(Toucher,Couler);
        etatFlotte=(aFlot,aSombrer);
        etatJoueur=(Gagne,Perd);

//CASES
//BUT : Cr‚ation d'une case
//ENTREE : l,c les lignes et colonnes; mCase la case … laquelle on associera les coordonn‚es
//SORTIE : une case est cr‚‚e avec des coordonn‚es
procedure creatCase(l,c:integer;var mCase:Cases);
        begin
        mCase.ligne:=l;
        mCase.colonne:=c;
        end;

//BUT : Comparaison de deux cases
//ENTREE : mCase ‚tant la case qu'on a cr‚‚ et tCase ‚tant la case qu'on va tester avec celle cr‚‚e
//SORTIE : vrai ou faux
function cmpCase(mCase,tCase:Cases):boolean;
        begin
        IF ((mCase.colonne=tCase.colonne) AND (mCase.ligne=tCase.ligne)) THEN
                begin
                cmpCase:=TRUE;
                end
        ELSE
                begin
                cmpCase:=FALSE;
                end;
        end;

//BATEAUX
//BUT : Cr‚ation d'un bateau
//ENTREE : mCase ‚tant les cases cr‚‚es, taille la taille du bateau,
//res la structure du bateau, posBateau ‚tant l'orientation du bateau puis pos une variable al‚atoire d‚finissant l'orientation du bateau,
//puis i ‚tant la variable pour naviguer sur les cases du bateau
//SORTIE : Structure de bateau renvoy‚e avec les coordonn‚es de ses cases
function creatBateau(mCase:Cases;taille:integer):Bateau;
        var
                res:Bateau;
                posBateau:positionBateau;
                pos,i:integer;

        begin
        //Alignement du bateau
        Randomize;
        pos:=random(3)+1;
        posBateau:=positionBateau(pos);
        //G‚n‚ration al‚atoire de sa taille
        taille:=random(MAXCASE)+1;

        //Cr‚ation du bateau en fonction de son orientation
        FOR i:=1 TO MAXCASE DO
                begin
                //Affectation de cases … un bateau
                IF (i<=taille) THEN
                        begin
                        res.nCase[i].ligne:=mCase.ligne;
                        res.nCase[i].colonne:=mCase.colonne;
                        end
                ELSE
                        //Par d‚faut si la taille du bateau est d‚pass‚e les coordonn‚es prendront la valeur 0
                        begin
                        res.nCase[i].ligne:=0;
                        res.nCase[i].colonne:=0;
                        end;

                //Orientation du bateau
                IF (posBateau=enLigne) THEN
                        begin
                        mCase.ligne:=mCase.ligne+1;
                        end
                ELSE
                        begin
                        IF (posBateau=enColonne) THEN
                                begin
                                mCase.colonne:=mCase.colonne+1;
                                end
                        ELSE
                                begin
                                IF (posBateau=enDiag) THEN
                                        begin
                                        mCase.ligne:=mCase.ligne+1;
                                        mCase.colonne:=mCase.colonne+1;
                                        end;
                                end;
                        end;
                end;
        end;

//BUT : V‚rifie si une case appartient d‚j… … un bateau ou non
//ENTREE : mBat ‚tant le bateau d'une flotte et mCase les cases occup‚es
//SORTIE : vrai ou faux
function ctrlCase(mBat:Bateau;mCase:Cases):boolean;
        var
                i:integer;
                valTest:boolean;

        begin
        valTest:=FALSE;
        FOR i:=1 TO MAXCASE DO
                begin
                IF (cmpCase(mBat.nCase[i],mCase)) THEN
                        begin
                        valTest:=TRUE;
                        end;
                end;
        ctrlCase:=valTest
        end;

//FLOTTE
//BUT : V‚rifie si une case appartient … une flotte ou non
//ENTREE : mFlotte ‚tant la flotte d'un joueur et mCase ‚tant les cases occup‚es
//SORTIE : vrai ou faux
function ctrlFlotte(mFlotte:Flotte;mCase:Cases):boolean;
        var
                i:integer;
                valTest:boolean;

        begin
        valTest:=FALSE;
        FOR i:=1 TO NBBATEAU DO
                begin
                IF (ctrlCase(mFlotte.nBateau[i],mCase)) THEN
                        begin
                        valtest:=TRUE;
                        end;
                end;
        ctrlFlotte:=valTest
        end;

//PROGRAMME PRINCIPAL
BEGIN
        clrscr;
        writeln('Programme : Bataille navale');
        writeln('Veuillez appuyer sur entr‚e pour continuer');
        readln;

END.