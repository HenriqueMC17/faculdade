package calculadora;

/**
 * Classe responsavel por realizar operacoes matematicas basicas.
 *
 * <p>Esta classe e utilizada pelo sistema FinancApp para realizar calculos
 * fundamentais como orcamento mensal, divisao de despesas e projecao de
 * economia financeira.</p>
 *
 * @author Aluno FinancApp
 * @version 1.0
 * @since 2026
 */
public class Calculadora {

    /**
     * Construtor padrao da classe Calculadora.
     * Instancia a calculadora pronta para uso.
     */
    public Calculadora() {
        // Construtor padrao
    }

    /**
     * Realiza uma operacao matematica entre dois numeros inteiros.
     *
     * <p>O metodo recebe dois operandos e um operador em formato de string,
     * identifica a operacao e retorna o resultado correspondente.
     * Caso a operacao seja invalida ou ocorra divisao por zero,
     * o metodo trata o erro sem interromper a execucao do programa.</p>
     *
     * @param a  Primeiro operando inteiro (dividendo no caso da divisao).
     * @param b  Segundo operando inteiro (divisor no caso da divisao).
     * @param op Operador matematico: {@code "+"}, {@code "-"},
     *           {@code "*"} ou {@code "/"}.
     * @return   O resultado da operacao como {@code double},
     *           ou {@code Double.NaN} em caso de erro.
     */
    public double calc(int a, int b, String op) {
        if (op == null || op.trim().isEmpty()) {
            System.out.println("Erro: Operador nao pode ser nulo ou vazio.");
            return Double.NaN;
        }
        switch (op.trim()) {
            case "+": return somar(a, b);
            case "-": return subtrair(a, b);
            case "*": return multiplicar(a, b);
            case "/": return dividir(a, b);
            default:
                System.out.println("Erro: Operacao invalida -> \"" + op + "\". Use: +, -, * ou /");
                return Double.NaN;
        }
    }

    /**
     * Realiza a soma de dois numeros inteiros.
     *
     * @param a Primeira parcela da soma.
     * @param b Segunda parcela da soma.
     * @return  A soma de {@code a} e {@code b}.
     */
    private double somar(int a, int b) {
        return a + b;
    }

    /**
     * Realiza a subtracao de dois numeros inteiros.
     *
     * @param a Minuendo (numero do qual se subtrai).
     * @param b Subtraendo (numero a ser subtraido).
     * @return  A diferenca entre {@code a} e {@code b}.
     */
    private double subtrair(int a, int b) {
        return a - b;
    }

    /**
     * Realiza a multiplicacao de dois numeros inteiros.
     *
     * @param a Primeiro fator da multiplicacao.
     * @param b Segundo fator da multiplicacao.
     * @return  O produto de {@code a} por {@code b}.
     */
    private double multiplicar(int a, int b) {
        return (double) a * b;
    }

    /**
     * Realiza a divisao de dois numeros inteiros.
     *
     * <p>Caso o divisor {@code b} seja zero, o metodo exibe uma mensagem de
     * erro e retorna {@code Double.NaN}, evitando a excecao
     * {@link ArithmeticException} e garantindo a continuidade do programa.</p>
     *
     * @param a Dividendo.
     * @param b Divisor. Nao pode ser zero.
     * @return  O quociente da divisao de {@code a} por {@code b},
     *          ou {@code Double.NaN} se {@code b} for zero.
     */
    private double dividir(int a, int b) {
        if (b == 0) {
            System.out.println("Erro: Divisao por zero nao e permitida.");
            return Double.NaN;
        }
        return (double) a / b;
    }

    /**
     * Metodo principal para demonstrar o funcionamento da calculadora.
     *
     * <p>Executa exemplos de cada operacao disponivel, incluindo casos de
     * erro como divisao por zero e operacao invalida.</p>
     *
     * @param args Argumentos de linha de comando (nao utilizados).
     */
    public static void main(String[] args) {
        Calculadora calc = new Calculadora();

        System.out.println("===========================================");
        System.out.println("  FinancApp - Modulo de Calculadora v1.0   ");
        System.out.println("===========================================");
        System.out.println();
        System.out.println(">> Soma:           10 + 5  = " + calc.calc(10, 5, "+"));
        System.out.println(">> Subtracao:      10 - 5  = " + calc.calc(10, 5, "-"));
        System.out.println(">> Multiplicacao:  10 * 5  = " + calc.calc(10, 5, "*"));
        System.out.println(">> Divisao:        10 / 5  = " + calc.calc(10, 5, "/"));
        System.out.println();
        System.out.println("-- Teste de divisao por zero:");
        calc.calc(10, 0, "/");
        System.out.println("-- Teste de operacao invalida:");
        calc.calc(10, 5, "%");
        System.out.println();
        System.out.println("===========================================");
        System.out.println("  Execucao concluida sem falhas!            ");
        System.out.println("===========================================");
    }
}