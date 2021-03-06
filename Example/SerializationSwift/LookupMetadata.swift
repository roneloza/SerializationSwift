//
//  ItunesItemMetadata.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

//{
//    "resultCount": 1,
//    "results": [
//    {
//    "isGameCenterEnabled": false,
//    "screenshotUrls": [
//    "https://is5-ssl.mzstatic.com/image/thumb/Purple118/v4/32/84/9e/32849e2c-9fd9-3f7a-1340-8f78e746475b/source/392x696bb.jpg",
//    "https://is4-ssl.mzstatic.com/image/thumb/Purple118/v4/9c/a8/00/9ca800a5-ca7b-9f99-f5a5-61f36aeffa35/source/392x696bb.jpg",
//    "https://is4-ssl.mzstatic.com/image/thumb/Purple118/v4/cd/d7/56/cdd75655-7ef3-c084-a543-79c10dda175f/source/392x696bb.jpg",
//    "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/7c/b5/a3/7cb5a3f6-dc5b-9844-147c-d7807f5f2e87/source/392x696bb.jpg",
//    "https://is5-ssl.mzstatic.com/image/thumb/Purple118/v4/54/3c/55/543c5585-da1f-74be-f06e-169acfac0e5f/source/392x696bb.jpg",
//    "https://is4-ssl.mzstatic.com/image/thumb/Purple118/v4/8d/43/ca/8d43ca3a-e658-cd20-d3ed-6e804eeb1ae2/source/392x696bb.jpg",
//    "https://is5-ssl.mzstatic.com/image/thumb/Purple128/v4/89/2d/dc/892ddcb7-2670-272a-5a19-d8c34dd237b6/source/392x696bb.jpg"
//    ],
//    "ipadScreenshotUrls": [],
//    "appletvScreenshotUrls": [],
//    "artworkUrl60": "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/81/76/fd/8176fdb9-b100-25fe-5015-0cba47bba141/source/60x60bb.jpg",
//    "artworkUrl512": "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/81/76/fd/8176fdb9-b100-25fe-5015-0cba47bba141/source/512x512bb.jpg",
//    "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/81/76/fd/8176fdb9-b100-25fe-5015-0cba47bba141/source/100x100bb.jpg",
//    "artistViewUrl": "https://itunes.apple.com/us/developer/servicios-de-franquicia-pardos-sac/id1340448710?uo=4",
//    "supportedDevices": [
//    "iPhone5-iPhone5",
//    "iPadFourthGen-iPadFourthGen",
//    "iPadFourthGen4G-iPadFourthGen4G",
//    "iPhone5c-iPhone5c",
//    "iPhone5s-iPhone5s",
//    "iPadAir-iPadAir",
//    "iPadAirCellular-iPadAirCellular",
//    "iPadMiniRetina-iPadMiniRetina",
//    "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
//    "iPhone6-iPhone6",
//    "iPhone6Plus-iPhone6Plus",
//    "iPadAir2-iPadAir2",
//    "iPadAir2Cellular-iPadAir2Cellular",
//    "iPadMini3-iPadMini3",
//    "iPadMini3Cellular-iPadMini3Cellular",
//    "iPodTouchSixthGen-iPodTouchSixthGen",
//    "iPhone6s-iPhone6s",
//    "iPhone6sPlus-iPhone6sPlus",
//    "iPadMini4-iPadMini4",
//    "iPadMini4Cellular-iPadMini4Cellular",
//    "iPadPro-iPadPro",
//    "iPadProCellular-iPadProCellular",
//    "iPadPro97-iPadPro97",
//    "iPadPro97Cellular-iPadPro97Cellular",
//    "iPhoneSE-iPhoneSE",
//    "iPhone7-iPhone7",
//    "iPhone7Plus-iPhone7Plus",
//    "iPad611-iPad611",
//    "iPad612-iPad612",
//    "iPad71-iPad71",
//    "iPad72-iPad72",
//    "iPad73-iPad73",
//    "iPad74-iPad74",
//    "iPhone8-iPhone8",
//    "iPhone8Plus-iPhone8Plus",
//    "iPhoneX-iPhoneX"
//    ],
//    "advisories": [],
//    "kind": "software",
//    "features": [],
//    "trackCensoredName": "Pardos Delivery",
//    "languageCodesISO2A": [
//    "EN"
//    ],
//    "fileSizeBytes": "43246592",
//    "contentAdvisoryRating": "4+",
//    "trackViewUrl": "https://itunes.apple.com/us/app/pardos-delivery/id1340448711?mt=8&uo=4",
//    "trackContentRating": "4+",
//    "formattedPrice": "Free",
//    "releaseDate": "2018-04-16T17:04:11Z",
//    "genreIds": [
//    "6023",
//    "6012"
//    ],
//    "primaryGenreId": 6023,
//    "trackId": 1340448711,
//    "trackName": "Pardos Delivery",
//    "primaryGenreName": "Food & Drink",
//    "currentVersionReleaseDate": "2018-04-16T17:04:11Z",
//    "sellerName": "Servicios de Franquicia Pardo's S.A.C.",
//    "currency": "USD",
//    "wrapperType": "software",
//    "version": "1.0",
//    "artistId": 1340448710,
//    "artistName": "Servicios de Franquicia Pardos SAC",
//    "genres": [
//    "Food & Drink",
//    "Lifestyle"
//    ],
//    "price": 0,
//    "description": "¡Ya está disponible la App de Pardos Chicken!\nDescárgate la aplicación móvil y empieza a descubrir todas las ventajas que tenemos para ti:\nVive la mejor experiencia Pardos en delivery.\nRealiza tus pedidos rápidamente sin necesidad de llamar por teléfono.\nConoce la variedad de nuestra carta.\nDisfruta del mejor sabor de lo nuestro en solo 3 pasos. \nPaga en efectivo o con Tarjeta (Visa o Mastercard).\nPaga con Visa desde tu celular o tablet. \nGuarda tus direcciones frecuentes.\nGeolocalización: reconocimiento de tu ubicación para poder guardar tu dirección con mayor facilidad.\nGracias a la aplicación de Pardos podrás solicitar tu pedido de delivery en tan solo un clic ¡Así de fácil! ¡Descárgatelo ya!",
//    "bundleId": "pe.pardoschicken.pardosapp",
//    "isVppDeviceBasedLicensingEnabled": true,
//    "minimumOsVersion": "10.3"
//    }
//    ]
//}

import SerializationSwift

final class LookupMetadata: BaseModel, ModelCodable {
    
    let resultCount: Int? = nil
    let results: [LookupResultOther]? = nil
    
    //MARK: - Life Cycle -
    
    enum CodingKeys: String, CodingKey, EnumCollection {
        
        case resultCount = "resultCount"
        case results = "results"
        
        /**
         If the properties and enumerations have the same order
         **/
        init?(intValue: Int) {
            
            if 0..<CodingKeys.allValues.count ~= intValue {
                
                self = CodingKeys.allValues[intValue]
            }
            else {
                
                return nil
            }
        }
        
        /**
         Associate the property name with an enumeration, regardless of the order
         **/
        init?(stringValue: String) {
            
            switch stringValue {
                
            case "resultCount" : self = .resultCount
            case "results" : self = .results
            default:
                return nil
            }
        }
    }
    
    /*
     * Necessary to overwrite using decoding manually when you have a array of objects
     */
    required init(from decoder: Decoder) throws {
        
        super.init()
        
        self.initialize(from: decoder, e: CodingKeys.self, p: self)
    }
    
    
    //MARK: - ModelCodableDelegate -
    
    func getCustomValue<E: CodingKey>(withDecoder decoder: Decoder, codingKeyEnum: E, className: String, propertyName: String) -> TupleCodableType {
        
        if className == String(describing: [LookupResult]?.self) {
            
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [LookupResult]?.self, className: className, propertyName: propertyName)
            
            return TupleCodableType(value, true)
        }
        
        return TupleCodableType(nil, false)
    }
}
