package exercicios;

import java.util.Scanner;

/**
 * Verificador de Número Par ou Ímpar
 * Demonstra o uso de operadores aritméticos (resto da divisão) e condicionais simples.
 */
public class VerificadorNumeroPar {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🔢 VERIFICADOR DE NÚMERO PAR/ÍMPAR 🔢\n");

        try {
            System.out.print("Digite um número inteiro: ");
            int numero = Integer.parseInt(scanner.nextLine().trim());

            System.out.println("\n=================================");
            if (numero % 2 == 0) {
                System.out.println("🟢 O número " + numero + " é PAR!");
            } else {
                System.out.println("🟡 O número " + numero + " é ÍMPAR!");
            }
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Digite apenas números inteiros.");
        } finally {
            scanner.close();
        }
    }
}
