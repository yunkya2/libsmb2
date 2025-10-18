/*
 *  poll()
 */

#include <poll.h>

int poll(struct pollfd *fds, nfds_t nfds, int timeout)
{
    int nevents = 0;
    for (nfds_t i = 0; i < nfds; i++) {
        fds[i].revents = 0;
        if (fds[i].events & POLLOUT) {
            fds[i].revents |= POLLOUT;
        } else if (fds[i].events & POLLIN) {
            fds[i].revents |= POLLIN;
        }
        if (fds[i].revents != 0) {
            nevents++;
        }
    }
    return nevents;
}
