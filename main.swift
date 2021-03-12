//
//  main.swift
//  calRenta250402016
//
//  Created by user152178 on 3/10/21.
//  Copyright © 2021 EdgardoGonzalez. All rights reserved.
//

import Foundation

func capturar(mensaje:String)->String{
    print(mensaje)
    var input = ""
    input = NSString(data: FileHandle.standardInput.availableData, encoding:String.Encoding.utf8.rawValue)! as String
    input = input.replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range: nil)
    return input
}

func impuestoRenta(salario:Double, tp:String)->String{
    var renta:Double = 0.0
    var porDescontar:Double = 0.0
    var cuotaFija:Double = 0.0
    var exceso:Double = 0.0
    
    if tp == "S"{
        switch salario {
        case 0.01...118.00:
            porDescontar = 0.0
            cuotaFija = 0.0
            exceso = 0.0
        case 118.01...223.81:
            porDescontar = 0.1
            cuotaFija = 4.42
            exceso = 118.0
        case 223.82...509.52:
            porDescontar = 0.2
            cuotaFija = 15.0
            exceso = 223.81
        default:
            porDescontar = 0.30
            cuotaFija = 72.14
            exceso = 509.52
        }
    }
    
    if tp == "Q"{
        switch salario{
        case 0.01...236.00:
            porDescontar = 0.0
            cuotaFija = 0.0
            exceso = 0.0
        case 236.1...447.62:
            porDescontar = 0.1
            cuotaFija = 8.83
            exceso = 236.00
        case 447.67...1019.05:
            porDescontar = 0.2
            cuotaFija =  30.0
            exceso = 447.62
        default:
            porDescontar = 144.28
            cuotaFija = 0.30
            exceso = 1019.05
        }
    }
    
    if tp == "M"{
        switch salario{
        case 0.01...472.00:
            porDescontar = 0.0
            cuotaFija = 0.0
            exceso = 0.0
        case 472.01...895.24:
            porDescontar = 0.10
            cuotaFija = 17.67
            exceso = 472.00
        case 896.25...2038.10:
            porDescontar = 0.20
            cuotaFija = 60.0
            exceso = 895.24
        default :
            porDescontar = 0.30
            cuotaFija = 288.57
            exceso = 2038.10
        }
    }
    
    renta = ((salario-exceso) * porDescontar) + cuotaFija
    let stRenta = String(format: "$%000.02f", renta)
    return String(stRenta)
}

func imprLista(nombres: Array<String>, salarios: Array<String>, tps: Array<String>, rentas: Array<String>, Duis: Array<String>){
    var colDui:String = ""
    var colNombre:String = ""
    var colSalario:String = ""
    var colFP:String = ""
    var lineaUp:String = ""
    var lineaDown:String = ""
    var titulo:String = ""
    var espacio:String = ""

    titulo = "\u{2551}    DUI     \u{2551}                NOMBRES                \u{2551}   SALARIO   \u{2551}   FP   \u{2551}    RENTA    \u{2551}"
    colDui = String(repeating: "\u{2550}",count: 13)
    colNombre = String(repeating: "\u{2550}",count: 39)
    colSalario = String(repeating: "\u{2550}",count: 13)
    colFP = String(repeating: "\u{2550}",count: 8)
    lineaUp = "\u{2554}\(colDui)\u{2566}\(colNombre)\u{2566}\(colSalario)\u{2566}\(colFP)\u{2566}\(colSalario)\u{2557}"
    lineaDown = "\u{2560}\(colDui)\u{256C}\(colNombre)\u{256C}\(colSalario)\u{256C}\(colFP)\u{256C}\(colSalario)\u{2563}"
    //print("\u{2560}\(lineaArriba)\u{2563}")
    //225D
    print (lineaUp)
    print(titulo)
    print(lineaDown)
    var numfil:Int = 0
    numfil = nombres.count
    for i in 0...numfil-1{
        espacio = String(repeating: " ", count: (38-nombres[i].count))
        print("\u{2551} \(Duis[i]) \u{2551} \(nombres[i])\(espacio)\u{2551}  $\(salarios[i])   \u{2551}   \(tps[i])   \u{2551}  $\(rentas[i])   \u{2551}")
        //  print(" \(nombres[i]) \(salarios[i]) \(tps[i]) r \(rentas[i])")
    }
    print(lineaDown)
    
}
//programa principal
var nombre:String = ""
var digitar:Bool = true
var salario:Double = 0.00
var tipoPago:String = ""
var dui:String = ""


//preparando la lista de usuarios
var duis:[String] = [String]()
var nombres:[String] = [String]()
var salarios:[String] = [String]()
var tps:[String] = [String]()
var rentas:[String] = [String]()

while(digitar){
    var entrada:Bool = true
    while(entrada){
        nombre = capturar(mensaje: "Ingrese el nombre del empleado").capitalized
        if nombre != "" && nombre.count < 39{
            entrada = false
        }else{
            print("debe ingresar el nombre")
        }
    }
    
salario = Double( capturar(mensaje: "ingrese el salario"))!
dui = capturar(mensaje: "ingrese documento DUI")
    entrada = true
    while(entrada){
        
    tipoPago = capturar(mensaje: "seleccione: S=semanal, Q=Quincenal, M=Mensual").uppercased()
        if tipoPago == "Q" || tipoPago == "R" || tipoPago == "S"{
            entrada = false
        }else{
            print("debe ingresar una de las letras mostradas")
        }
    }
    nombres.append(nombre)
    salarios.append(String(salario))
    tps.append(tipoPago)
    rentas.append(impuestoRenta(salario:salario, tp:tipoPago))
    duis.append(dui)
    
    let detener = capturar(mensaje: "Desea ingresar otra persona? S=si, N=no").uppercased()
    if detener  == "N"{
    digitar = false
    }
}
imprLista(nombres:nombres,salarios:salarios,tps:tps, rentas:rentas,Duis:duis)
