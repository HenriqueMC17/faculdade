package calculadora;

/**
 * Classe de testes unitarios para a classe {@link Calculadora}.
 *
 * <p>Esta classe implementa testes manuais sem o uso de framework externo,
 * verificando o comportamento correto da calculadora para cada operacao
 * disponivel, incluindo casos de erro.</p>
 *
 * <p>Cada teste exibe: entradas utilizadas, resultado esperado e
 * resultado obtido, facilitando a identificacao de falhas.</p>
 *
 * @author Aluno FinancApp
 * @version 1.0
 * @since 2026
 */
public class TesteCalculadora {

    /** Instancia da calculadora utilizada em todos os testes. */
    private static Calculadora calculadora = new Calculadora();

    /** Contador de testes executados. */
    private static int totalTestes = 0;

    /** Contador de testes aprovados. */
    private static int testesPassados = 0;

    /** Contador de testes reprovados. */
    private static int testesFalhados = 0;

    /**
     * Construtor padrao da classe TesteCalculadora.
     */
    public TesteCalculadora() {
        // Construtor padrao
    }

    /**
     * Ponto de entrada da classe de testes.
     * Executa todos os grupos de testes e exibe o relatorio final.
     *
     * @param args Argumentos de linha de comando (nao utilizados).
     */
    public static void main(String[] args) {
        System.out.println("============================================");
        System.out.println("  RELATORIO DE TESTES -- TesteCalculadora   ");
        System.out.println("============================================");
        System.out.println();
        testarSoma();
        testarSubtracao();
        testarMultiplicacao();
        testarDivisao();
        testarDivisaoPorZero();
        testarOperacaoInvalida();
        exibirRelatorioFinal();
    }

    /**
     * Executa testes unitarios para a operacao de soma.
     * Verifica soma de positivos, negativos e com zero.
     */
    private static void testarSoma() {
        System.out.println("--- TESTES DE SOMA ---");
        executarTeste("Soma positivos (10 + 5)",    10,  5, "+",  15.0);
        executarTeste("Soma com negativo (-3 + 7)", -3,  7, "+",   4.0);
        executarTeste("Soma com zero (8 + 0)",       8,  0, "+",   8.0);
        System.out.println();
    }

    /**
     * Executa testes unitarios para a operacao de subtracao.
     * Verifica subtracao com resultado positivo, negativo e zero.
     */
    private static void testarSubtracao() {
        System.out.println("--- TESTES DE SUBTRACAO ---");
        executarTeste("Subtracao positiva (10 - 5)", 10, 5, "-",  5.0);
        executarTeste("Subtracao negativa (3 - 9)",   3, 9, "-", -6.0);
        executarTeste("Subtracao zero (7 - 7)",        7, 7, "-",  0.0);
        System.out.println();
    }

    /**
     * Executa testes unitarios para a operacao de multiplicacao.
     * Verifica multiplicacao de positivos, por zero e com negativo.
     */
    private static void testarMultiplicacao() {
        System.out.println("--- TESTES DE MULTIPLICACAO ---");
        executarTeste("Multiplicacao positivos (4 * 5)",  4, 5, "*",  20.0);
        executarTeste("Multiplicacao por zero (6 * 0)",   6, 0, "*",   0.0);
        executarTeste("Multiplicacao negativo (-3 * 4)", -3, 4, "*", -12.0);
        System.out.println();
    }

    /**
     * Executa testes unitarios para a operacao de divisao.
     * Verifica divisao exata, com resultado decimal e divisao de zero.
     */
    private static void testarDivisao() {
        System.out.println("--- TESTES DE DIVISAO ---");
        executarTeste("Divisao exata (10 / 5)",  10, 5, "/", 2.0);
        executarTeste("Divisao decimal (7 / 2)",  7, 2, "/", 3.5);
        executarTeste("Divisao de zero (0 / 5)",  0, 5, "/", 0.0);
        System.out.println();
    }

    /**
     * Executa testes unitarios para o caso de divisao por zero.
     * Verifica se o sistema retorna NaN sem lancar excecao.
     */
    private static void testarDivisaoPorZero() {
        System.out.println("--- TESTES DE DIVISAO POR ZERO ---");
        executarTesteNaN("Divisao por zero (10 / 0)",  10,  0, "/");
        executarTesteNaN("Divisao por zero (-5 / 0)", -5,  0, "/");
        System.out.println();
    }

    /**
     * Executa testes unitarios para operadores invalidos.
     * Verifica se o sistema retorna NaN para operadores nao reconhecidos,
     * incluindo operadores desconhecidos e operador nulo.
     */
    private static void testarOperacaoInvalida() {
        System.out.println("--- TESTES DE OPERACAO INVALIDA ---");
        executarTesteNaN("Operacao invalida '%' (10 % 5)", 10, 5, "%");
        executarTesteNaN("Operacao invalida '^' (2 ^ 3)",  2,  3, "^");
        executarTesteNaN("Operador nulo (null)",           10,  5, null);
        System.out.println();
    }

    /**
     * Executa um teste comparando o resultado obtido com o esperado.
     *
     * <p>Exibe as entradas, resultado esperado, resultado obtido e
     * o status do teste (PASSOU / FALHOU).</p>
     *
     * @param descricao Descricao textual do teste.
     * @param a         Primeiro operando.
     * @param b         Segundo operando.
     * @param op        Operador matematico.
     * @param esperado  Resultado numerico esperado.
     */
    private static void executarTeste(String descricao, int a, int b,
                                      String op, double esperado) {
        totalTestes++;
        double obtido = calculadora.calc(a, b, op);
        boolean passou = Double.compare(obtido, esperado) == 0;

        System.out.println("  Teste    : " + descricao);
        System.out.println("  Entradas : a=" + a + ", b=" + b + ", op=\"" + op + "\"");
        System.out.println("  Esperado : " + esperado);
        System.out.println("  Obtido   : " + obtido);
        System.out.println("  Status   : " + (passou ? "[PASSOU]" : "[FALHOU]"));
        System.out.println();

        if (passou) testesPassados++;
        else        testesFalhados++;
    }

    /**
     * Executa um teste esperando {@code Double.NaN} como resultado.
     *
     * <p>Utilizado para testar casos de erro onde o sistema nao pode
     * retornar um valor numerico valido.</p>
     *
     * @param descricao Descricao textual do teste.
     * @param a         Primeiro operando.
     * @param b         Segundo operando.
     * @param op        Operador matematico (pode ser nulo).
     */
    private static void executarTesteNaN(String descricao, int a, int b, String op) {
        totalTestes++;
        double obtido = calculadora.calc(a, b, op);
        boolean passou = Double.isNaN(obtido);

        System.out.println("  Teste    : " + descricao);
        System.out.println("  Entradas : a=" + a + ", b=" + b + ", op=\"" + op + "\"");
        System.out.println("  Esperado : NaN (erro tratado)");
        System.out.println("  Obtido   : " + obtido);
        System.out.println("  Status   : " + (passou ? "[PASSOU]" : "[FALHOU]"));
        System.out.println();

        if (passou) testesPassados++;
        else        testesFalhados++;
    }

    /**
     * Exibe o relatorio consolidado de todos os testes executados.
     * Informa o total, aprovados, reprovados e o resultado geral.
     */
    private static void exibirRelatorioFinal() {
        System.out.println("============================================");
        System.out.println("             RELATORIO FINAL                ");
        System.out.println("============================================");
        System.out.println("  Total de testes   : " + totalTestes);
        System.out.println("  Testes passados   : " + testesPassados);
        System.out.println("  Testes falhados   : " + testesFalhados);
        System.out.println("--------------------------------------------");
        if (testesFalhados == 0) {
            System.out.println("  RESULTADO: TODOS OS TESTES PASSARAM! =)");
        } else {
            System.out.println("  RESULTADO: " + testesFalhados + " teste(s) FALHARAM!");
        }
        System.out.println("============================================");
    }
}