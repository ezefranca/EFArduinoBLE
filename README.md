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
pod 'kit-iot-wearable-ios'
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
Veja a lista de comandos [aqui](https://github.com/telefonicadigital/kit-iot-wearable/wiki/Comandos-do-Wearable)


## Autor
| [![twitter/ezefranca](https://avatars0.githubusercontent.com/u/3648336?v=3&u=c9cf380aa967f5eb9cbb0097db0dd8586875dd6d&s?s=80)](http://twitter.com/ezefranca "Follow @ezefranca on Twitter") |
|---|
| [ezefranca](http://ezefranca.com) |

