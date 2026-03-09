# octave
Deu pau de novo
# fortran

Para compilar

```sh
gfortran fft.f90 -lfftw3 -o fft_audio
```

Para plotar

```sh
./fft_audio && gnuplot -p -e "plot 'results.dat' with lines"
```
