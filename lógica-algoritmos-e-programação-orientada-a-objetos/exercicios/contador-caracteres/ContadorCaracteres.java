package exercicios;

import java.util.Scanner;

/**
 * Contador de Caracteres, Vogais e Consoantes
 * Demonstra manipulação de Strings, laços de repetição e condicionais.
 */
public class ContadorCaracteres {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("📝 CONTADOR DE CARACTERES");

        try {
            System.out.print("Digite uma frase/texto: ");
            String texto = scanner.nextLine();

            int totalCaracteresComEspaco = texto.length();
            int totalCaracteresSemEspaco = 0;
            int totalVogais = 0;
            int totalConsoantes = 0;
            int totalNumeros = 0;
            int totalOutros = 0;

            String textoMinusculo = texto.toLowerCase();

            for (int i = 0; i < textoMinusculo.length(); i++) {
                char c = textoMinusculo.charAt(i);

                if (c == ' ') {
                    continue;
                }
                
                totalCaracteresSemEspaco++;

                if (c >= 'a' && c <= 'z') {
                    if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                        totalVogais++;
                    } else {
                        totalConsoantes++;
                    }
                } else if (c >= '0' && c <= '9') {
                    totalNumeros++;
                } else {
                    totalOutros++;
                }
            }

            System.out.println("\n=================================");
            System.out.println("📊 RESULTADO DA ANÁLISE");
            System.out.println("=================================");
            System.out.println("Texto original: \"" + texto + "\"");
            System.out.println("---------------------------------");
            System.out.println("Total de caracteres (com espaços): " + totalCaracteresComEspaco);
            System.out.println("Total de caracteres (sem espaços): " + totalCaracteresSemEspaco);
            System.out.println("Vogais (a, e, i, o, u)           : " + totalVogais);
            System.out.println("Consoantes                       : " + totalConsoantes);
            System.out.println("Números (0-9)                    : " + totalNumeros);
            System.out.println("Símbolos/Pontuação/Especiais     : " + totalOutros);
            System.out.println("=================================");

        } catch (Exception e) {
            System.out.println("❌ Ocorreu um erro: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
