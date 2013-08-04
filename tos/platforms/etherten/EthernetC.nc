/*
 * Copyright (c) 2012-2013 Johny Mattsson
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the copyright holders nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#include "Atm328pSpi.h"
configuration EthernetC
{
  provides interface EtherAddress;
  provides interface Resource as EthernetChip;

  provides interface HplW5100Socket as HplSocket[uint8_t sock_no];
  provides interface SocketMemory;
}
implementation
{
  enum { SPI_CLIENT_ID = unique(SPI_RESOURCE) };

  components PlatformP, PlatformSpiC, HwW5100SpiC, ArduinoPinsC,
    new Atm328pGpioInterruptC() as IrqC, HplAtm328pExtInterruptC as HplExtIrqC;

  IrqC.HplAtm328pIoInterrupt -> HplExtIrqC.Int0;

  HwW5100SpiC.FastSpiByte    -> PlatformSpiC;
  HwW5100SpiC.SS             -> ArduinoPinsC.Digital[10];
  HwW5100SpiC.GpioInterrupt  -> IrqC;

  components HplW5100C, HplW5100SocketC, SocketMemoryP;
  HplW5100C.Hw        -> HwW5100SpiC;
  HplW5100SocketC.Hw  -> HwW5100SpiC;
  HplW5100SocketC.Hpl -> HplW5100C;
  SocketMemoryP.Hw    -> HwW5100SpiC;
  SocketMemoryP.Hpl   -> HplW5100C;

  HplSocket = HplW5100SocketC;
  SocketMemory = SocketMemoryP;

  EthernetChip = PlatformSpiC.Resource[SPI_CLIENT_ID];

  components EtherAddressC;
  EtherAddressC.Resource -> PlatformSpiC.Resource[SPI_CLIENT_ID];

  EtherAddress = EtherAddressC;

  // TODO: Check if enabling the w5100 interrupt at this point has any
  // unintended side-effects
  PlatformP.PlatformInit -> HwW5100SpiC;
}