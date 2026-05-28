package exercicios;

import java.util.Scanner;

/**
 * Calculadora de Peso Ideal e Saúde
 * Aplica fórmulas matemáticas baseadas em gênero e altura, com tratamento de erros.
 */
public class CalculadoraPeso {

    public static double calcularPesoIdeal(double altura, char sexo) {
        if (sexo == 'M' || sexo == 'm') {
            return (72.7 * altura) - 58.0;
        } else if (sexo == 'F' || sexo == 'f') {
            return (62.1 * altura) - 44.7;
        } else {
            throw new IllegalArgumentException("Sexo inválido! Deve ser 'M' (masculino) ou 'F' (feminino).");
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("⚖️ CALCULADORA DE PESO IDEAL ⚖️\n");

        try {
            System.out.print("Digite sua altura em metros (Ex: 1,75 ou 1.75): ");
            double altura = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));
            if (altura <= 0.5 || altura > 3.0) {
                System.out.println("❌ Altura irrealista informada!");
                return;
            }

            System.out.print("Informe seu sexo biológico (M para Masculino / F para Feminino): ");
            char sexo = scanner.nextLine().trim().toUpperCase().charAt(0);
            if (sexo != 'M' && sexo != 'F') {
                System.out.println("❌ Sexo incorreto! Digite apenas 'M' ou 'F'.");
                return;
            }

            System.out.print("Informe seu peso atual em kg (opcional, ou Enter para pular): ");
            String pesoInput = scanner.nextLine().trim().replace(",", ".");
            double pesoAtual = -1;
            if (!pesoInput.isEmpty()) {
                pesoAtual = Double.parseDouble(pesoInput);
                if (pesoAtual <= 0 || pesoAtual > 500) {
                    System.out.println("❌ Peso inválido.");
                    return;
                }
            }

            double pesoIdeal = calcularPesoIdeal(altura, sexo);
            System.out.println("\n=================================");
            System.out.printf("👉 Seu Peso Ideal Calculado: %.2f kg\n", pesoIdeal);

            if (pesoAtual != -1) {
                System.out.printf("👉 Seu Peso Atual: %.2f kg\n", pesoAtual);
                double diferenca = pesoAtual - pesoIdeal;
                
                // Faixa aceitável de 5% para mais ou para menos
                double margem = pesoIdeal * 0.05;
                if (Math.abs(diferenca) <= margem) {
                    System.out.println("🟢 Excelente! Você está dentro da faixa de peso ideal.");
                } else if (diferenca > margem) {
                    System.out.printf("🔴 Você está %.2f kg acima do peso ideal.\n", diferenca);
                } else {
                    System.out.printf("🟡 Você está %.2f kg abaixo do peso ideal.\n", Math.abs(diferenca));
                }
            }
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Verifique se digitou os números no formato correto.");
        } catch (IllegalArgumentException e) {
            System.out.println("❌ " + e.getMessage());
        } catch (Exception e) {
            System.out.println("❌ Erro inesperado: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
