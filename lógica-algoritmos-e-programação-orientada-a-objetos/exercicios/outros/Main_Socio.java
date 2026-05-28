package Aula_7;

public class Main_Socio {
    public static void main(String[] args) {
        Socio s1 = new Socio("Fabio");
        
        Dependente d1 = new Dependente("Igor");
        s1.addDependente(d1);
        
        Dependente d2 =  new Dependente("Ana Lívia");
        s1.addDependente(d2);
        
        s1.imprimir();
        s1.imprimirDependentes();
    }
}
