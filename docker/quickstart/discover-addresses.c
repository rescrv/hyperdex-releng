/* Copyright (c) 2015, Robert Escriva
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of libtreadstone nor the names of its contributors may
 *       be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <arpa/inet.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <ifaddrs.h>

int
main(int argc, const char* argv[])
{
    char buf[64];
    struct ifaddrs* ifa = NULL;
    struct ifaddrs* ifap = NULL;
    struct sockaddr_in* sa = NULL;
    struct sockaddr_in6* sa6 = NULL;

    if (getifaddrs(&ifa) < 0 || !ifa)
    {
        fprintf(stderr, "could not detect local address\n");
        return EXIT_FAILURE;
    }

    for (ifap = ifa; ifap; ifap = ifap->ifa_next)
    {
        if (strncmp(ifap->ifa_name, "lo", 2) == 0)
        {
            continue;
        }

        if (ifap->ifa_addr->sa_family == AF_INET)
        {
            sa = (struct sockaddr_in*)ifap->ifa_addr;

            if (!inet_ntop(AF_INET, &sa->sin_addr, buf, sizeof(buf)))
            {
                continue;
            }
        }
        else if (ifap->ifa_addr->sa_family == AF_INET6)
        {
            sa6 = (struct sockaddr_in6*)ifap->ifa_addr;

            if (!inet_ntop(AF_INET, &sa6->sin6_addr, buf, sizeof(buf)))
            {
                continue;
            }
        }
        else
        {
            continue;
        }

        printf("%s %s\n", ifap->ifa_name, buf);
    }

    freeifaddrs(ifa);
    return EXIT_SUCCESS;
}


