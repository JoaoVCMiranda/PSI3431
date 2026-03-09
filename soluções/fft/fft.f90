program fft_audio
    use, intrinsic :: iso_c_binding
    implicit none

    ! Inclui a interface da FFTW
    include '/usr/include/fftw3.f03'

    ! Parameters for a standard 16-bit Mono WAV
    integer, parameter :: n_samples = 1048576
    integer(2), dimension(n_samples) :: raw_samples
    ! Correct type for FFTW
    type(c_ptr) :: plan
    !integer(8) :: plan
    
    ! Arrays para entrada (real) e saída (complexa)
    !real(8), dimension(n_samples) :: audio_in
    !complex(16), dimension(n_samples/2 + 1) :: fft_out
    real(c_double), dimension(n_samples) :: audio_in
    complex(c_double), dimension(n_samples/2 + 1) :: fft_out
    integer :: i, ios
    real(8) :: freq, sampling_rate

    sampling_rate = 44100.0d0 ! Frequência de amostragem padrão
    
    ! open stream
    open(unit=10, file='/home/jvcm/Projetos/karaokay/audio/Eddies_Twister.wav', access='stream', form='unformatted', status='old')

    ! 2. Skip the 44-byte header by reading 44 dummy bytes
    ! Or simply start reading from position 45
    read(10, pos=45, iostat=ios) raw_samples
    close(10)

    if (ios /= 0 .and. ios /= -1) then ! -1 is End of File
        print *, "Error reading file or file too short."
    end if

    ! 3. Convert 16-bit Integers to Normalized Floats (-1.0 to 1.0)
    ! 32768.0 is the max value for a signed 16-bit int
    do i = 1, n_samples
        audio_in(i) = real(raw_samples(i), c_double) / 32768.0d0
    end do

    ! 1. Simulação de um sinal de áudio (Senoide de 440Hz - Nota Lá)
    !do i = 1, n_samples
    !    audio_in(i) = sin(2.0d0 * 3.141592653589793d0 * 440.0d0 * (i-1) / sampling_rate)
    !end do

    ! 2. Criação do plano FFTW (Real-to-Complex)
    ! O plano otimiza o algoritmo para o hardware atual
    plan = fftw_plan_dft_r2c_1d(n_samples, audio_in, fft_out, FFTW_ESTIMATE)

    ! 3. Execução da FFT
    call fftw_execute_dft_r2c(plan, audio_in, fft_out)

    !!!!
    
    open(unit=20, file='fft_result.dat', status='replace')
      write(20, *) "# Frequency(Hz) Magnitude"
      
      do i = 1, n_samples/2 + 1
          ! Calculate the real frequency based on a 44.1kHz sample rate
          freq = (i-1) * sampling_rate / n_samples
          ! Write frequency and the absolute value (magnitude) of the complex result
          write(20, '(F12.2, E15.6)') freq, abs(fft_out(i))
      end do
      
      close(20)
      print *, "Data saved to fft_result.dat"

    !!!!

    ! 4. Cálculo e exibição das frequências dominantes (Magnitude)
    !print *, "Frequência (Hz) | Magnitude"
    !do i = 1, n_samples/2 + 1
    !    freq = (i-1) * sampling_rate / n_samples
    !    print '(F10.2, " | ", F10.5)', freq, abs(fft_out(i))
    !end do

    ! 5. Limpeza de memória
    call fftw_destroy_plan(plan)

end program fft_audio
