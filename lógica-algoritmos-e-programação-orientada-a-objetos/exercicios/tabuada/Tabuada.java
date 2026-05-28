package exercicios;

import java.util.Scanner;

/**
 * Calculador de Tabuada
 * Solicita um número ao usuário e imprime a tabuada completa de 1 a 10.
 */
public class Tabuada {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🔢 CALCULADOR DE TABUADA 🔢\n");

        try {
            System.out.print("Digite um número inteiro para ver sua tabuada: ");
            int numero = Integer.parseInt(scanner.nextLine().trim());

            System.out.println("\n=================================");
            System.out.println("👉 TABUADA DO " + numero + ":");
            System.out.println("=================================");
            for (int i = 1; i <= 10; i++) {
                System.out.printf("%2d x %2d = %2d\n", numero, i, (numero * i));
            }
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Insira apenas números inteiros.");
        } finally {
            scanner.close();
        }
    }
}
