package Aula_7;

public class Main_Func {
    public static void main(String[] args) {
        Funcionario f1 = new Funcionario("Fabio");
        Funcionario f2 = new Funcionario("Helio");
        Funcionario f3 = new Funcionario("ELiney");
        
        f3.addFuncionario(f1);
        f3.addFuncionario(f2);
        
        f3.imprimir();
        f3.imprimirFuncionarios();
    }
}
