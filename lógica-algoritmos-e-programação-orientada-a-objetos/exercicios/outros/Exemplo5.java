package Aula_2;

import java.util.Scanner;

public class Exemplo5 {

    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);

        System.out.println("Username:");
        String username = scan.nextLine();

        System.out.println("Senha:");
        String senha = scan.nextLine();

        boolean validacao = checkLogin(username, senha);

        if (validacao == true) {

        }
    }

    public static boolean checkLogin(String user, String pass) {
        if (user.equals("admin") && pass.equals("123")) {
            return true;
        } else {
            return false;
        }
    }
}
