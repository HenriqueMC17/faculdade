package exercicios;

import java.util.Arrays;
import java.util.Scanner;

/**
 * Operações com Vetores (Arrays)
 * Mostra como dimensionar, popular, pesquisar, reverter e extrair métricas de arrays unidimensionais.
 */
public class ExerciciosVetores {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("📊 MANIPULAÇÃO DE VETORES (ARRAYS) 📊\n");

        try {
            System.out.print("Defina o tamanho do vetor (Ex: 5): ");
            int tamanho = Integer.parseInt(scanner.nextLine().trim());
            if (tamanho <= 0) {
                System.out.println("❌ O tamanho do vetor deve ser maior que zero.");
                return;
            }

            double[] vetor = new double[tamanho];
            for (int i = 0; i < tamanho; i++) {
                System.out.print("Digite o valor para a posição [" + i + "]: ");
                vetor[i] = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
            }

            // 1. Calcular Média
            double soma = 0;
            for (double val : vetor) {
                soma += val;
            }
            double media = soma / tamanho;

            // 2. Achar Maior e Menor
            double maior = vetor[0];
            double menor = vetor[0];
            for (int i = 1; i < tamanho; i++) {
                if (vetor[i] > maior) maior = vetor[i];
                if (vetor[i] < menor) menor = vetor[i];
            }

            System.out.println("\n=================================");
            System.out.println("📈 RESULTADOS DA ANÁLISE DO VETOR");
            System.out.println("=================================");
            System.out.println("Vetor original   : " + Arrays.toString(vetor));
            System.out.printf("Média dos valores: %.4f\n", media);
            System.out.printf("Maior valor      : %.4f\n", maior);
            System.out.printf("Menor valor      : %.4f\n", menor);
            
            // 3. Exibir na ordem inversa
            System.out.print("Ordem inversa    : [");
            for (int i = tamanho - 1; i >= 0; i--) {
                System.out.print(vetor[i]);
                if (i > 0) System.out.print(", ");
            }
            System.out.println("]");
            System.out.println("=================================");

            // 4. Busca no vetor
            System.out.print("\nDigite um número para buscar no vetor: ");
            double busca = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
            int indexEncontrado = -1;
            for (int i = 0; i < tamanho; i++) {
                if (vetor[i] == busca) {
                    indexEncontrado = i;
                    break;
                }
            }

            if (indexEncontrado != -1) {
                System.out.println("🟢 Encontrado! O número " + busca + " está na posição [" + indexEncontrado + "].");
            } else {
                System.out.println("🔴 O número " + busca + " não foi encontrado no vetor.");
            }

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Verifique os números digitados.");
        } finally {
            scanner.close();
        }
    }
}
