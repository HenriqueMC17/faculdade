package calculadora_salario_professor;

import java.util.Scanner;

/**
 * Calculadora de Salário de Professor
 * Calcula salários brutos e líquidos deduzindo taxas previdenciárias de forma dinâmica.
 */
public class CalculadoraSalarioProfessor {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("💸 CALCULADORA DE SALÁRIO DE PROFESSOR 💸\n");

        try {
            System.out.print("Informe o valor da hora-aula (R$): ");
            double valorHora = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            System.out.print("Informe o número de horas-aula trabalhadas no mês: ");
            double horasTrabalhadas = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            System.out.print("Informe o percentual de desconto do INSS (Ex: 11 para 11%): ");
            double percentualInss = Double.parseDouble(scanner.nextLine().trim().replace(",", "."));

            if (valorHora <= 0 || horasTrabalhadas <= 0 || percentualInss < 0) {
                System.out.println("❌ Os valores informados devem ser positivos.");
                return;
            }

            // Salário Bruto = valorHora * horasTrabalhadas
            double salarioBruto = valorHora * horasTrabalhadas;

            // Desconto INSS = Salário Bruto * (percentualInss / 100)
            double descontoInss = salarioBruto * (percentualInss / 100.0);

            // Salário Líquido = Salário Bruto - Desconto INSS
            double salarioLiquido = salarioBruto - descontoInss;

            System.out.println("\n=================================");
            System.out.println("📄 DEMONSTRATIVO DE PAGAMENTO");
            System.out.println("=================================");
            System.out.printf("Valor da Hora-Aula   : R$ %8.2f\n", valorHora);
            System.out.printf("Horas Trabalhadas    : %11.2f h\n", horasTrabalhadas);
            System.out.printf("Salário Bruto        : R$ %8.2f\n", salarioBruto);
            System.out.printf("Desconto INSS (%.1f%%): R$ %8.2f\n", percentualInss, descontoInss);
            System.out.println("---------------------------------");
            System.out.printf("Salário Líquido      : R$ %8.2f\n", salarioLiquido);
            System.out.println("=================================");

        } catch (NumberFormatException e) {
            System.out.println("❌ Entrada inválida! Certifique-se de digitar apenas números.");
        } catch (Exception e) {
            System.out.println("❌ Ocorreu um erro: " + e.getMessage());
        } finally {
            scanner.close();
        }
    }
}
