package exercicios;

import java.util.Scanner;

/**
 * Calculador de Volume de Lata de Óleo
 * Aplica a fórmula do volume de um cilindro: V = pi * R^2 * H, tratando dados de entrada.
 */
public class VolumeLataOleo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("🛢️ CÁLCULO DE VOLUME DE LATA DE ÓLEO 🛢️\n");

        try {
            System.out.print("Digite o raio da lata (em cm): ");
            double raio = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            System.out.print("Digite a altura da lata (em cm): ");
            double altura = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            if (raio <= 0 || altura <= 0) {
                System.out.println("❌ Dimensões inválidas! Raio e altura devem ser maiores que zero.");
                return;
            }

            // Fórmula: V = pi * raio^2 * altura
            double volume = Math.PI * Math.pow(raio, 2) * altura;
            
            // Conversão aproximada para Litros (1 litro = 1000 cm³)
            double volumeLitros = volume / 1000.0;

            System.out.println("\n=================================");
            System.out.println("📊 DIMENSÕES DA LATA");
            System.out.println("=================================");
            System.out.printf("Raio   : %.2f cm\n", raio);
            System.out.printf("Altura : %.2f cm\n", altura);
            System.out.println("---------------------------------");
            System.out.printf("👉 Volume calculado: %.4f cm³\n", volume);
            System.out.printf("👉 Equivalente a   : %.4f Litros\n", volumeLitros);
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Digite apenas valores numéricos para raio e altura.");
        } finally {
            scanner.close();
        }
    }
}
