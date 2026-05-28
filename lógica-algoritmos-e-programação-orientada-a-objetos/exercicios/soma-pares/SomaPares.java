package exercicios;

import java.util.Scanner;

/**
 * Calculador de Soma de Números Pares em um Intervalo
 * Demonstra condicionais (resto da divisão) e loops acumuladores.
 */
public class SomaPares {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🔢 SOMATÓRIO DE NÚMEROS PARES 🔢\n");

        try {
            System.out.print("Digite o número de início do intervalo: ");
            int inicio = Integer.parseInt(scanner.nextLine().trim());

            System.out.print("Digite o número de fim do intervalo: ");
            int fim = Integer.parseInt(scanner.nextLine().trim());

            if (inicio > fim) {
                System.out.println("⚠️ O valor de início é maior que o fim. Invertendo o intervalo automaticamente...");
                int temp = inicio;
                inicio = fim;
                fim = temp;
            }

            int soma = 0;
            int count = 0;
            
            System.out.print("Números pares encontrados: ");
            for (int i = inicio; i <= fim; i++) {
                if (i % 2 == 0) {
                    System.out.print(i + " ");
                    soma += i;
                    count++;
                }
            }
            System.out.println(); // Salta linha após exibir lista de pares

            System.out.println("=================================");
            System.out.println("📊 RESULTADOS:");
            System.out.println("=================================");
            System.out.println("Intervalo avaliado: [" + inicio + " a " + fim + "]");
            System.out.println("Quantidade de pares: " + count);
            System.out.println("👉 Soma Total dos pares: " + soma);
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Insira apenas números inteiros.");
        } finally {
            scanner.close();
        }
    }
}
