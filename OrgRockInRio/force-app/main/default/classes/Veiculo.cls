public virtual class Veiculo {

    public String nome;
    public String cor;
    public Decimal valor;
    public List<Peca> pecas;
    
    public virtual Decimal retornaValorLiquido() {
        return valor*0.6;
    }
    
    public Decimal retornaValorLiquido(Decimal percentual) {
        return valor*percentual;
    }
}