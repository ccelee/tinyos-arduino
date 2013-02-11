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
#include "w5100.h"
interface IPv4Network
{
  /**
   * Attempts to set the IPv4 address.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param addr The address to set.
   * @returns SUCCESS if set, or EBUSY if the bus could not be immediately
   *   acquired.
   */
  command error_t setAddress (in_addr_t addr);
  /**
   * Attempts to get the current IPv4 address.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param addr Where to store the retrieved address.
   * @returns SUCCESS if the address was read, or EBUSY if the bus could
   *   not be immediately acquired, in which case @c addr was not touched.
   */
  command error_t getAddress (in_addr_t *addr);


  /**
   * Attempts to set the IPv4 gateway.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param addr The gateway address to set.
   * @returns SUCCESS if set, or EBUSY if the bus could not be immediately
   *   acquired.
   */
  command error_t setGateway (in_addr_t addr);
  /**
   * Attempts to get the current IPv4 gateway.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param addr Where to store the retrieved gateway address.
   * @returns SUCCESS if the gateway address was read, or EBUSY if the bus
   *   could not be immediately acquired, in which case @c addr was not touched.
   */
  command error_t getGateway (in_addr_t *addr);


  /**
   * Attempts to set the IPv4 subnet mask.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param mask The subnet mask to set.
   * @returns SUCCESS if set, or EBUSY if the bus could not be immediately
   *   acquired.
   */
  command error_t setSubnetMask (in_addr_t mask);
  /**
   * Attempts to get the current IPv4 subnet mask.
   * Requires the bus to the ethernet chip to be available.
   *
   * @param mask Where to store the retrieved mask.
   * @returns SUCCESS if the subnet mask was read, or EBUSY if the bus could
   *   not be immediately acquired, in which case @c mask was not touched.
   */
  command error_t getSubnetMask (in_addr_t *mask);
}
