class Plano{
    var nome: Sring
    
    init(nome: String){
        self.nome = nome
    }

    func calcularMensalidade() -> Double{
        return 0.0
    }
}

class PlanoMensal: Plano{
    init(){
        super.init(nome: "PLano Mensal")
    }
    override func calcularMensalidade() -> Double{
        return 120.0
    }
}
