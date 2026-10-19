class Equipo{
    const property nombre
    const energiaBase
    const property entrenador
    const tecnologiasComplementarias = []

    method agregarTecnologia(unaTecnologia){
        tecnologiasComplementarias.add(unaTecnologia)
    }
    method tecnologiasActivas(){
        return tecnologiasComplementarias.filter({t => t.estaActiva()})
    }
    method energiaDeTecnologiasActivas(){
        return self.tecnologiasActivas().sum({t => t.valorEnergetico()})
    }
    method energiaTotal(){
        return energiaBase + self.energiaDeTecnologiasActivas()
    }
    method esDePrestigioUniversal()
}

class Luminico inherits Equipo{
    const radiacionCapturada = 0
    const cristalesSolares = []

    method agregarCristales(unCristal){
        cristalesSolares.add(unCristal)
    }
    override method energiaTotal(){
        return if(radiacionCapturada < 5000) super() * 1.1 else super() 
    }
    override method esDePrestigioUniversal(){
        return (cristalesSolares.size() >= 3) and (entrenador.esDeEliteGalactica()) and (self.tecnologiasActivas().size() > 0)
    }
}

class Sintetico inherits Equipo{
    const property procesamientoCentral = 0
    const modulosActivos = 0
    const establesParaCompeticion = true

    override method energiaTotal(){
        return if(modulosActivos > 5) super() - ((energiaBase + self.energiaDeTecnologiasActivas()) * 0.2) else super() 
    }
    override method esDePrestigioUniversal(){
        return (establesParaCompeticion) and (modulosActivos > 3) and ((tecnologiasComplementarias.size() == self.tecnologiasActivas().size()) and not tecnologiasComplementarias.isEmpty())
    }
}

class Eterico inherits Equipo{
    const fluctuacionDimensional = 0
    const cantPortalesEnerAbiertos = 0

    override method energiaTotal(){
        return if(self.esDePrestigioUniversal()) super() * 1.15 else super()
    }
    override method esDePrestigioUniversal(){
        return (fluctuacionDimensional > 75) and (cantPortalesEnerAbiertos >= 2) and (self.tecnologiasActivas().size() >= 2)
    }
}

class Entrenador{
    const cicloSolarExperiencia 
    const precisionEstrategica = 0
    const property estaEnSintoniaConEquipo = true
    var rol
    const rolesDeEntrenador = ["Estratega Cuántico", "Arquitecto de Energía", "Guía Mental"]

    method cambiarRol(nuevoRol){
        if(not rolesDeEntrenador.contains(nuevoRol)){
            self.error("Rol no homologado por la FOZ")
        } else{
            rol = nuevoRol
        }
    }
    method esDeEliteGalactica(){
        if (rol == "Estratega Cuántico"){
            return (cicloSolarExperiencia > 10) and (precisionEstrategica > 80)
        } else if (rol == "Arquitecto de Energía"){
            return (cicloSolarExperiencia > 10) and (estaEnSintoniaConEquipo)
        } else {
            return cicloSolarExperiencia > 10
        }
    }
}

class TecnologiaEspecial{
    const property nombre
    const property valorEnergetico
    var activa = true

    method estaActiva() = activa
    method activar() {activa = true}
    method desactivar() {activa = false}
}