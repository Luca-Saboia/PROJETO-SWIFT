class Plano{
    var nome: String
    
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

class PlanoAnual : Plano {
    init() {
        super.init(nome: "Plano Anual (Promocional)")
    }

    override func calcularMensalidade() -> Double {
        return 120 * 0.8 
    }
}