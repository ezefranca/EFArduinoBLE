# kit-iot-wearable-ios
Kit IoT Wearable iOS  http://iot.telefonicabeta.com/kit-iot-wearable


# Kit IoT Wearable Telefonica VIVO - iOS
[![Build Status](http://img.shields.io/travis/ezefranca/kit-iot-wearable-ios.svg?style=flat)](https://travis-ci.org/ezefranca/kit-iot-wearable-ios)
[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/kit-iot-wearable-ios/badge.png)](http://cocoadocs.org/docsets/FSK-Arduino-iOS)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/kit-iot-wearable-ios/badge.svg)](http://cocoadocs.org/docsets/FSK-Arduino-iOS)
[![wercker status](https://app.wercker.com/status/7d5a33ceed1006aae64e3937f40d2bf1/s "wercker status")](https://app.wercker.com/project/bykey/554b5f78acb272dc78095c87)

Biblioteca [iOS](http://apple.com/) para conectar via bluetooth com o [Kit de Desenvolvimento IoT Wearable](http://iot.telefonicabeta.com/).

#### O kit possui os seguintes sensores:
  * Módulo Bluetooth - ([HM-13](http://www.fasttech.com/product/1827700-hm-13-dual-mode-bluetooth-4-0-ble-spp-le-serial))
  * Luminosidade
  * Temperatura
  * Acelerômetro
    * eixo x
    * eixo y
    * eixo z
  * LED RGB
  * Buzzer


#### Mantenha o Sketch Arduino do seu Kit IoT Wearable atualizado
[Link](https://github.com/telefonicadigital/kit-iot-wearable-arduino) - faça o download do sketch e suba no seu Kit Wearable utilizando a IDE do Arduino.


## Como utilizar

### Via CocoaPods

Para utilizar a bibliteca instale utilizando [cocoapods](http://cocoapods.org/). No seu podfile acrescente:

```
pod 'EFArduinoBLE'
```

#### Exemplo de utilização

No DevicesVC.h temos uma UITableView que exibe os dados de um ```NSMutableArray``` de dispositivos bluetooth.
Um exemplo de conexão e envio de dados:

No delegate da UITableView
```c
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

DevicesVC.m

{
[...]
    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"XPTO"];
    controller.iotKit = kitIoT;
    [self.navigationController pushViewController:controller animated:YES];
}


ViewController.m

@interface ViewController ()
@property (strong, nonatomic) IOTArduino *iotKit;
@end

@implementation ViewController
@synthesize iotKit;

//Exemplo, deixar o LED RGB AZUL
- (void)sendToArduino {
    [iotKit sendCommandToArduino:@"#LR0000"];
    [iotKit sendCommandToArduino:@"#LG0000"];
    [iotKit sendCommandToArduino:@"#LB0255"];
}


```
### Documentação do Módulo bluetooth HM-13
Veja a documentação do módulo bluetooth HM-13 - [link](http://www.seeedstudio.com/wiki/images/3/32/Bluetooth_HM-13_en.pdf)


## Lista de comandos do Wearable
Veja a lista de comandos [aqui](https://github.com/telefonicadigital/kit-iot-wearable/wiki/Comandos-padr%C3%B5es-do-Wearable)

## Outros Projetos

Biblioteca Python para controlar o Kit-IoT-Wearable através do Intel Galileo [Aqui](https://github.com/renanlino/wearablePython-galileo) por [@renanlino](https://github.com/renanlino)

Lib iOS Swift [Aqui](https://github.com/telefonicadigital/kit-iot-wearable-ios)

## Autor
| [![twitter/ezefranca](http://1.gravatar.com/avatar/3b4da2efb9fda1566a2907dd551fc907?s=48&d=%3Cpath_to_url%3E&r=PG)](http://twitter.com/ezefranca "Follow @ezefranca on Twitter") |
|---|
| [ezefranca](http://ezefranca.com) |

